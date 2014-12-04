function camera_plot_data(data)

% Originalni data
figure;
plot(data);
title('0. originalni data');

% Odstraneni spatnych fotoclanku
disp('bad photocells');
data = camera_fix(data,'bad photocells')

figure;
plot(data);
title('1. Odstraneni spatnych fotoclanku');

% Oseknuti
disp('Oseknuti');
data = camera_fix(data,'cut');
oseknuta_data = data

figure;
plot(data);
title('2. oseknuti dat');

% Vyhlazeni
disp('Vyhlazeni');
data = camera_fix(data,'smooth')

figure;
plot(data);
title('3. vyhlazeni dat');

% Gradient
disp('Gradient');
gradient = camera_fix(data,'gradient')

figure;
plot(gradient);
title('4. Gradent');

% Filter gradient
disp('Filter gradient');
gradient = camera_fix(gradient,'filter gradient')

figure;
plot(gradient);
title('5. Filter Gradent');
axis([0, length(gradient), -1.2, 1.2]);

% Cut gradient
disp('Cut gradient');
gradient = camera_fix(gradient,'cut gradient')

figure;
plot(gradient);
title('6. Cut Gradent');
axis([0, length(gradient), -1.2, 1.2]);

% Detect lines
disp('Detect lines');
lines = camera_fix(gradient,'detect lines')

% print hodnotu posunutou na puvodni index
lines_orig_index = lines + 14

figure;
plot(oseknuta_data);
title('7. detekce car');
hold on;

for i = 1:length(lines(:,1)) 
    line([lines(i,1) lines(i,1)], [min(oseknuta_data) max(oseknuta_data)], 'Color', 'red');
    line([lines(i,2) lines(i,2)], [min(oseknuta_data) max(oseknuta_data)], 'Color', 'red');
end




