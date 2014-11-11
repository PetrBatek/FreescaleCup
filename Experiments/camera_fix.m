function out = camera_fix(in, stage)

switch stage
    case 'cut'
        out = in(15:112)
end

end