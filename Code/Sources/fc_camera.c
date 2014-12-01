#include "derivative.h" /* include peripheral declarations */
#include "TFC\TFC.h"
#include "fc_camera.h"

unsigned int i,n,min,max;

unsigned int cut_down = 14;
unsigned int cut_top = 16;

unsigned int fcc_camera_data[128];
unsigned int a_length = 98; // 128 - cut_down - cut_top
unsigned int fcc_camera_data_cut[98]; 
unsigned int fcc_camera_data_help[98]; // help variable
double fcc_camera_gradient[97]; // gradients (128 - cut_down - cut_top - 1)
double fcc_gradient_threshold = 0.03;
unsigned int fcc_lines[10][2]; // fcc_lines[0][0] == number of lines

/* Volej tuhle metodu */
extern int * fcc_get_line_data(void){
	/** Get data from camera **/
	memcpy(fcc_camera_data, LineScanImage0, 128);
	
	/** fix bad photocels **/
	// propad hodnoty - nahradime je prumerem okolnich hodnot
	fcc_camera_data[39] = (fcc_camera_data[38]+fcc_camera_data[40])/2;
	fcc_camera_data[73] = (fcc_camera_data[72]+fcc_camera_data[74])/2;
	
	// cut bad side values **/
	for(i = 0; i<(128-cut_top); i++){
		fcc_camera_data_cut[i] = fcc_camera_data[i+cut_down];
	}
	
	/** smoothing **/
	fcc_camera_data_help[0] = (fcc_camera_data_cut[0]+fcc_camera_data_cut[1])/2;
	fcc_camera_data_help[a_length-1] = (fcc_camera_data_cut[a_length-2]+fcc_camera_data_cut[a_length-1])/2;
	
	for(i = 1; i<a_length-1; i++){
		fcc_camera_data_help[i] = (fcc_camera_data_cut[i-1]+fcc_camera_data_cut[i]+fcc_camera_data_cut[i+1])/3;
	}
	memcpy(fcc_camera_data_cut, fcc_camera_data_help, a_length);
	
	/** get gradient **/
	// nastav minimalni hodnotu na 0
	min = fcc_camera_data_cut[0];
	max = fcc_camera_data_cut[0];
	for(i = 0; i<a_length; i++){
		if (min > fcc_camera_data_cut[i]){
			min = fcc_camera_data_cut[i];
		}
		if (max < fcc_camera_data_cut[i]){
			max = fcc_camera_data_cut[i];
		}
	}
	max = max - min;
	for(i = 0; i<a_length; i++){
		fcc_camera_data_cut[i] = fcc_camera_data_cut[i] - min;
	}
	// spocte gradient 
	for(i = 0; i<a_length-1; i++){
		fcc_camera_gradient[i] = ((double)fcc_camera_data_cut[i+1] - (double)fcc_camera_data_cut[i])/(double)max;
	}
	
	/** filter gradient **/
	for(i = 0; i<a_length-1; i++){
		if (fcc_camera_gradient[i] > fcc_gradient_threshold){
			fcc_camera_gradient[i] = 1;
		}
		else if(fcc_camera_gradient[i] < -fcc_gradient_threshold){
			fcc_camera_gradient[i] = -1;
		}
		else{
			fcc_camera_gradient[i] = 0;
		}
	}
	
	/** cut gradient **/
	// odstrani poklesy na stranach
	// zleva
	for(i = 0; i<a_length-1; i++){
		if (fcc_camera_gradient[i] > 0){
			fcc_camera_gradient[i] = 0;
		}
		else{
			break;
		}
	}
	// zprava
	for(i = a_length-1; i>=0; i--){
		if (fcc_camera_gradient[i] < 0){
			fcc_camera_gradient[i] = 0;
		}
		else{
			break;
		}
	}
	
	/** detect lines **/
	// detekuje cerne pruhy
	static unsigned int min_to_zero[20];  // pozice kde se -1 mneni na 0
	static unsigned int min_to_zero_len = 0; 
	static unsigned int zero_to_max[20]; // pozice kde se 0 mneni na 1 
	static unsigned int zero_to_max_len = 0; 
	fcc_lines[0][0] = 0;
	
	for(i = 0; i<a_length-2; i++){
		if (fcc_camera_gradient[i] == -1 && fcc_camera_gradient[i+1] == 0 && min_to_zero_len < 20){
			min_to_zero[min_to_zero_len] = i;
			min_to_zero_len++;
		}else if (fcc_camera_gradient[i] == 0 && fcc_camera_gradient[i+1] == 1 && zero_to_max_len < 20){
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
					fcc_lines[0][0]++;
					break;
				}
			}
		}
		
		// posledni skok na 0
		for (n = 0; n<zero_to_max_len; n++){
			if (zero_to_max[n] > min_to_zero[min_to_zero_len-1]){
				fcc_lines[fcc_lines[0][0]+1][0] = min_to_zero[min_to_zero_len-1];
				fcc_lines[fcc_lines[0][0]+1][1] = zero_to_max[n];
				fcc_lines[0][0]++;
				break;
			}
		}
	}
	
	/** posun pozice car na puvodni indexy **/
	for (i = 1; i< fcc_lines[0][0]+1; i++){
		fcc_lines[i][0] += cut_down;
		fcc_lines[i][1] += cut_down;
	}
	
	/** return array pointer to array with results **/
	return fcc_lines;
}



