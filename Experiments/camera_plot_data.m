function camera_plot_data(data)

% Originalni data
figure;
plot(data);
title('0. originalni data');

% Odstraneni spatnych fotoclanku
data = camera_fix(data,'bad photocells');

figure;
plot(data);
title('1. Odstraneni spatnych fotoclanku');

% Oseknuti
data = camera_fix(data,'cut');

figure;
plot(data);
title('2. oseknuti dat');