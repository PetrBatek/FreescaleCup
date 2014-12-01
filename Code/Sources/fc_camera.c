#include "derivative.h" /* include peripheral declarations */
#include "TFC\TFC.h"
#include "fc_camera.h"

unsigned int i;

unsigned int cut_down = 14;
unsigned int cut_top = 16;

unsigned int fcc_camera_data[128];
unsigned int a_length = 98; // 128 - cut_down - cut_top
signed int fcc_camera_data_cut[98]; 
signed int fcc_camera_data_help[98]; // help variable
unsigned int fcc_lines[10][2];

/* Volej tuhle metodu */
extern int * fcc_get_line_data(void){
	// Get data from camera
	memcpy(fcc_camera_data, LineScanImage0, 128);
	
	// fix bad photocels
	// propad hodnoty - nahradime je prumerem okolnich hodnot
	fcc_camera_data[39] = (fcc_camera_data[38]+fcc_camera_data[40])/2;
	fcc_camera_data[73] = (fcc_camera_data[72]+fcc_camera_data[74])/2;
	
	// cut bad side values
	for(i = 0; i<(128-cut_top); i++){
		fcc_camera_data_cut[i] = fcc_camera_data[i+cut_down];
	}
	
	// smoothing
	fcc_camera_data_help[0] = (fcc_camera_data_cut[0]+fcc_camera_data_cut[1])/2;
	fcc_camera_data_help[a_length-1] = (fcc_camera_data_cut[a_length-2]+fcc_camera_data_cut[a_length-1])/2;
	
	for(i = 1; i<a_length-1; i++){
		fcc_camera_data_help[i] = (fcc_camera_data_cut[i-1]+fcc_camera_data_cut[i]+fcc_camera_data_cut[i+1])/3;
	}
	memcpy(fcc_camera_data_cut, fcc_camera_data_help, a_length);
	
	// get gradient
	// TODO
	
	// filter gradient
	// TODO
	
	// cut gradient
	// TODO
	
	//detect lines
	// TODO
	
	// return array pointer to array with results
	return fcc_lines;
}
    
/*case 'gradient'
    l = length(in);
    in = in - min(in); % nastav minimalni hodnotu na 0
    in_max = max(in);
    out = zeros(1,l-1); % pole gradientu ma o jedna mensi velikost
    
    for i = 1:(l-1)
        out(i) = (in(i+1) - in(i)) / in_max;
    end*/
    
/*case 'filter gradient'
    l = length(in);
    for i = 1:l
        if in(i) > 0.03
            in(i) = 1;
        elseif in(i) < -0.03
            in(i) = -1;
        else
            in(i) = 0;
        end
    end
    out = in;*/

/*case 'cut gradient' % odstrani poklesy na stranach
    l = length(in);
    out = in;
    
    % zleva
    for i = 1:l
        if out(i)>0
            out(i) = 0;
        else
            break;
        end
    end
    
    % zprava
    for i = fliplr(1:l)
        if out(i)<0
            out(i) = 0;
        else
            break;
        end
    end*/

/*case 'detect lines' % detekuje cerne pruhy
    l = length(in);
    
    min_to_zero = []; % pozice kde se -1 mneni na 0
    zero_to_max = []; % pozice kde se 0 mneni na 1 
    for i = 1:(l-1)
        if in(i) == -1 && in(i+1) == 0
            min_to_zero = [min_to_zero,i];
        elseif in(i) == 0 && in(i+1) == 1
            zero_to_max = [zero_to_max,i];
        end
    end
    
    lines = [];
    
    if length(min_to_zero)>=1
        for i = 1:length(min_to_zero)-1
            for n = 1:length(zero_to_max)
                if zero_to_max(n) > min_to_zero(i) && zero_to_max(n) < min_to_zero(i+1)
                    lines = [lines; min_to_zero(i), zero_to_max(n)];
                    break
                end
            end
        end
        
        % posledni skok na 0
        for n = 1:length(zero_to_max)
            if zero_to_max(n) > min_to_zero(length(min_to_zero))
                lines = [lines; min_to_zero(length(min_to_zero)), zero_to_max(n)];
                break
            end
        end
    end
    
    out = lines;*/

