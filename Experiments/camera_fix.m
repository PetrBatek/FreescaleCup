function out = camera_fix(in, stage)

switch stage
    case 'bad photocells' % uncut input
        in(39); % propad hodnoty
        in(73); % propad hodnoty
        
        % nahradime je prumerem okolnich hodnot
        in(39) = (in(38)+in(40))/2.0;
        in(73) = (in(72)+in(74))/2.0;
        out = in;
    
    case 'cut'
        out = in(15:112);
    
    case 'smooth'
        l = length(in);
        out = zeros(1,l);
        
        out(1) = (in(1) + in(2))/2.0;
        out(l) = (in(l-1) + in(l))/2.0;
        for i = 2:(l-1)
           out(i) = (in(i-1) + in(i) + in(i+1))/3.0;
        end
        
    case 'gradient'
        l = length(in);
        in = in - min(in); % nastav minimalni hodnotu na 0
        in_max = max(in);
        out = zeros(1,l-1); % pole gradientu ma o jedna mensi velikost
        
        for i = 1:(l-1)
            out(i) = (in(i+1) - in(i)) / in_max;
        end
        
    case 'filter gradient'
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
        out = in;
        
    case 'cut gradient' % odstrani poklesy na stranach
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
        end
        
    case 'detect lines' % detekuje cerne pruhy
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
        
        min_to_zero
        zero_to_max
        
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
        
        out = lines;
end

end