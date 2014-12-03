#include "fc_camera.h"

int fcc_debug = 1;

unsigned int fcc_cut_down = 14;
unsigned int fcc_cut_top = 16;
double fcc_gradient_threshold = 0.03;

extern struct return_struct fcc_get_line_data(int raw_camera_line[128]){
	/** init + clean static values **/
	unsigned int i,n = 0;
	
	/** copy data to local variable **/
	unsigned int fcc_raw_data[128];
	memcpy(fcc_raw_data, raw_camera_line, 128);
	
	/** fix bad photocels **/
	// propad hodnoty - nahradime je prumerem okolnich hodnot
	fcc_raw_data[39] = (fcc_raw_data[38]+fcc_raw_data[40])/2;
	fcc_raw_data[73] = (fcc_raw_data[72]+fcc_raw_data[74])/2;
	
	/** cut bad side values **/
	unsigned int a_len = 128 - fcc_cut_down - fcc_cut_top; // 98 ; 128 - fcc_cut_down - fcc_cut_top
	unsigned int data_cut[a_len]; 
	
	for(i = 0; i<(128-fcc_cut_top); i++){
		data_cut[i] = fcc_raw_data[i+fcc_cut_down];
	}
	
	/** smoothing **/
	unsigned int data_help[a_len]; // help variable
	
	data_help[0] = (data_cut[0]+data_cut[1])/2;
	data_help[a_len-1] = (data_cut[a_len-2]+data_cut[a_len-1])/2;
	
	for(i = 1; i<a_len-1; i++){
		data_help[i] = (data_cut[i-1]+data_cut[i]+data_cut[i+1])/3;
	}
	memcpy(data_cut, data_help, a_len);
	
	/** get gradient **/
	unsigned int min,max;
	double data_gradient[a_len - 1]; // gradients ; 97 ; (128 - fcc_cut_down - fcc_cut_top - 1)
	
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
	for(i = a_len-1; i>=0; i--){
		if (data_gradient[i] < 0){
			data_gradient[i] = 0;
		}
		else{
			break;
		}
	}
	
	/** detect lines **/
	unsigned int fcc_lines[10][2]; // fcc_lines[0][0] == number of lines
    fcc_lines[0][0] = 0;
	unsigned int min_to_zero[20];  // pozice kde se -1 mneni na 0
	unsigned int min_to_zero_len = 0; 
	unsigned int zero_to_max[20]; // pozice kde se 0 mneni na 1 
	unsigned int zero_to_max_len = 0; 
    // TODO - set values of arrays to 0s, else inits with high numbers?????
	
	for(i = 0; i<a_len-2; i++){
		if (data_gradient[i] == -1 && data_gradient[i+1] == 0 && min_to_zero_len < 20){
			min_to_zero[min_to_zero_len] = i;
			min_to_zero_len++;
		}else if (data_gradient[i] == 0 && data_gradient[i+1] == 1 && zero_to_max_len < 20){
			zero_to_max[zero_to_max_len] = i;
			zero_to_max_len++;
		}
	}
	
	if (min_to_zero_len >=1){
		for (i = 0; i<min_to_zero_len-1; i++){
			for (n = 0; n<zero_to_max_len; n++){
				if (zero_to_max[n] > min_to_zero[i] && zero_to_max[n] < min_to_zero[i+1]){
					fcc_lines[fcc_lines[0][0]+1][0] = min_to_zero[i];
					fcc_lines[fcc_lines[0][0]+1][1] = zero_to_max[n];
					fcc_lines[0][0]+=1;
					break;
				}
			}
		}
		
		// posledni skok na 0
		for (n = 0; n<zero_to_max_len; n++){
			if (zero_to_max[n] > min_to_zero[min_to_zero_len-1]){
				fcc_lines[fcc_lines[0][0]+1][0] = min_to_zero[min_to_zero_len-1];
				fcc_lines[fcc_lines[0][0]+1][1] = zero_to_max[n];
				fcc_lines[0][0]+=1;
				break;
			}
		}
	}
	
	/** posun pozice car na puvodni indexy **/
	for (i = 1; i< fcc_lines[0][0]+1; i++){
		fcc_lines[i][0] += fcc_cut_down;
		fcc_lines[i][1] += fcc_cut_down;
	}
    
    /** debug **/
    if (fcc_debug == 1){
        printf("Printing lines array:\n");
        for (i=0; i<10; i++){
            for (n=0; n<2; n++){
                printf("%d ", fcc_lines[i][n]);
            }
            printf("\n");
        }
    }
	
	/** return array with results **/
	struct return_struct temp;
	memcpy(temp.lines, fcc_lines, 20); // TODO - zjistit jestli je 20 spravna velikost
    
    return temp; //TODO - Segmentation fault
}



