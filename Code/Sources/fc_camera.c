#include "fc_camera.h"

static int fcc_debug = 0;

static unsigned int fcc_cut_down = 14;
static unsigned int fcc_cut_top = 16;
static double fcc_gradient_threshold = 0.03;

static void fcc_debug_print_array(int data[128], char name[]){
    if (fcc_debug == 1){      
        unsigned int i = 0;
        printf("%s:\n", name);
        for (i=0; i<128; i++)
            printf("%d ", data[i]);
        printf("\n\n");
        }
    }
    
static void fcc_debug_print_array_d(double data[128], char name[]){
    if (fcc_debug == 1){      
        unsigned int i = 0;
        printf("%s:\n", name);
        for (i=0; i<128; i++)
            printf("%g ", data[i]);
        printf("\n\n");
        }
    }
    
extern void fcc_set_debug(int debug_mode){
    fcc_debug = debug_mode;
    }

extern struct fcc_return_struct fcc_get_line_data(int raw_camera_line[128]){
	/** init + clean static values **/
	unsigned int i,n = 0;
	
    fcc_debug_print_array(raw_camera_line, "Fcn_Input");
    
	/** copy data to local variable **/
	unsigned int fcc_raw_data[128] = { 0 };
	memcpy(fcc_raw_data, raw_camera_line, 128*sizeof(raw_camera_line[0]));
    
    fcc_debug_print_array(fcc_raw_data, "Raw_Data");
	
	/** fix bad photocels **/
	// propad hodnoty - nahradime je prumerem okolnich hodnot
	fcc_raw_data[38] = (fcc_raw_data[37]+fcc_raw_data[39])/2;
	fcc_raw_data[72] = (fcc_raw_data[71]+fcc_raw_data[73])/2;
    
    fcc_debug_print_array(fcc_raw_data, "Fix_Bad_Photocels");
	
	/** cut bad side values **/
	unsigned int a_len = 128 - fcc_cut_down - fcc_cut_top; // 98 ; 128 - fcc_cut_down - fcc_cut_top
	unsigned int data_cut[128] = { 0 };             
	
	for(i = 0; i<(128-fcc_cut_top-fcc_cut_down); i++){
		data_cut[i] = fcc_raw_data[i+fcc_cut_down];
	}
    
    fcc_debug_print_array(data_cut, "Data_Cut");
	
	/** smoothing **/
	unsigned int data_help[128] = { 0 }; // help variable
	
	data_help[0] = (data_cut[0]+data_cut[1])/2;
	data_help[a_len-1] = (data_cut[a_len-2]+data_cut[a_len-1])/2;
	
	for(i = 1; i<a_len-1; i++){
		data_help[i] = (data_cut[i-1]+data_cut[i]+data_cut[i+1])/3;
	}
	memcpy(data_cut, data_help, a_len*sizeof(data_help[0]));
    
    fcc_debug_print_array(data_cut, "Smoothed");
	
	/** get gradient **/
	unsigned int min,max;
	double data_gradient[128] = { 0 }; // gradients ; 97 ; (128 - fcc_cut_down - fcc_cut_top - 1)
	
	// nastav minimalni hodnotu na 0
	min = data_cut[0];
	max = data_cut[0];
	for(i = 0; i<a_len; i++){
		if (min > data_cut[i]){
			min = data_cut[i];
		}
		if (max < data_cut[i]){
			max = data_cut[i];
		}
	}
	max = max - min;
	for(i = 0; i<a_len; i++){
		data_cut[i] = data_cut[i] - min;
	}
	// spocte gradient 
	for(i = 0; i<a_len-1; i++){
		data_gradient[i] = ((double)data_cut[i+1] - (double)data_cut[i])/(double)max;
	}
    
    fcc_debug_print_array_d(data_gradient, "Get_Gradient");
	
	/** filter gradient **/
	for(i = 0; i<a_len-1; i++){
		if (data_gradient[i] > fcc_gradient_threshold){
			data_gradient[i] = 1;
		}
		else if(data_gradient[i] < -fcc_gradient_threshold){
			data_gradient[i] = -1;
		}
		else{
			data_gradient[i] = 0;
		}
	}
    
    fcc_debug_print_array_d(data_gradient, "Filter_Gradient");
	
	/** cut gradient **/
	// odstrani poklesy na stranach
	// zleva
	for(i = 0; i<a_len-1; i++){
		if (data_gradient[i] > 0){
			data_gradient[i] = 0;
		}
		else{
			break;
		}
	}
	// zprava
	for(i = a_len-2; i>=0; i--){
		if (data_gradient[i] < 0){
			data_gradient[i] = 0;
		}
		else{
			break;
		}
	}
    
    fcc_debug_print_array_d(data_gradient, "Cut_Gradient");
	
	/** detect lines **/
	unsigned int fcc_lines[10][2] = { 0 }; 
    unsigned int lines_num = 0;
	unsigned int min_to_zero[20] = { 0 };  // pozice kde se -1 mneni na 0
	unsigned int min_to_zero_len = 0; 
	unsigned int zero_to_max[20] = { 0 }; // pozice kde se 0 mneni na 1 
	unsigned int zero_to_max_len = 0; 
	
	for(i = 0; i<a_len-2; i++){
		if (data_gradient[i] == -1 && data_gradient[i+1] == 0 && min_to_zero_len < 20){
			min_to_zero[min_to_zero_len] = i;
			min_to_zero_len++;
		}else if (data_gradient[i] == 0 && data_gradient[i+1] == 1 && zero_to_max_len < 20){
			zero_to_max[zero_to_max_len] = i;
			zero_to_max_len++;
		}
	}
    
    if (fcc_debug == 1){
        printf("min_to_zero:\n");
        for (i = 0; i<20; i++)
            printf("%d, ", min_to_zero[i]);
        printf("\nzero_to_max:\n");
        for (i = 0; i<20; i++)
            printf("%d, ", zero_to_max[i]);
        printf("\n\n");        
    }
	
	if (min_to_zero_len >=1){
		for (i = 0; i<min_to_zero_len-1; i++){
			for (n = 0; n<zero_to_max_len; n++){
                if (lines_num>=9){
                    break; // lines array is full
                }
				else if (zero_to_max[n] > min_to_zero[i] && zero_to_max[n] < min_to_zero[i+1]){
					fcc_lines[lines_num][0] = min_to_zero[i];
					fcc_lines[lines_num][1] = zero_to_max[n];
					lines_num+=1;
					break;
				}
			}
		}
        
        if (lines_num<9){ // lines array is not full
            // posledni skok na 0
            for (n = 0; n<zero_to_max_len; n++){
                if (zero_to_max[n] > min_to_zero[min_to_zero_len-1]){
                    fcc_lines[lines_num][0] = min_to_zero[min_to_zero_len-1];
                    fcc_lines[lines_num][1] = zero_to_max[n];
                    lines_num+=1;
                    break;
                }
            }
        }
	}
	
	// posun pozice car na puvodni indexy
	for (i = 0; i< lines_num; i++){
		fcc_lines[i][0] += fcc_cut_down;
		fcc_lines[i][1] += fcc_cut_down;
	}
	
	/** return array with results **/
	struct fcc_return_struct temp;
    temp.lines_num = lines_num;
	memcpy(temp.lines, fcc_lines, 20*sizeof(fcc_lines[0][0])); // TODO - zjistit jestli je 20 spravna velikost
    
    return temp; 
}



