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

% Vyhlazeni
data = camera_fix(data,'smooth');

figure;
plot(data);
title('3. vyhlazeni dat');

% Gradient
gradient = camera_fix(data,'gradient');

figure;
plot(gradient);
title('4. Gradent');

% Filter gradient
gradient = camera_fix(gradient,'filter gradient');

figure;
plot(gradient);
title('5. Filter Gradent');
axis([0, length(gradient), -1.2, 1.2]);

% Cut gradient
gradient = camera_fix(gradient,'cut gradient');

figure;
plot(gradient);
title('6. Cut Gradent');
axis([0, length(gradient), -1.2, 1.2]);
