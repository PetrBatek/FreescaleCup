function plot_serial
  hFigure = figure('Position',[200 200 1000 500],...    %# Create a figure window
                   'MenuBar','none',...
                   'KeyPressFcn',@stop_keypress);
  
  hButton = uicontrol(hFigure,'Style','pushbutton',...  %# Create the button
                      'Position',[20 10 80 25],...
                      'String','Stop',...
                      'HorizontalAlignment','center',...
                      'Callback',@stop_button);
  
  s = serial('com7', 'BaudRate', 115200);
  s.Terminator = 'LF/CR';
  fopen(s);
 
  keepLooping = true;
  while keepLooping       %# Loop while keepLooping is true
    data = fgetl(s);
    C = str2num(data)
    plot(C);
    drawnow          
  end
  
  fclose(s);
  
%#---Begin nested functions---
  function stop_keypress(hObject,eventData)
    if strcmp(eventData.Key,'q')             %# If q key is pressed, set
      keepLooping = false;                   %#   keepLooping to false
    end
  end
  function stop_button(hObject,eventData)
    keepLooping = false;                     %# Set keepLooping to false
  end
end