function out = camera_fix(in, stage)

switch stage
    case 'bad photocells' % uncut input
        in(39); % propad hodnoty
        in(73); % propad hodnoty
        
        % nahradime je prumerem okolnich hodnot
        in(39) = (in(38)+in(40))/2.0;
        in(73) = (in(72)+in(74))/2.0;
        out = in
    
    case 'cut'
        out = in(15:112);
end

end