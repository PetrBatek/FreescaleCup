clear all;
close all;

% data z kamery pri nasmerovani na bile svitici lcd monitor.
a1 = [562,563,571,603,648,861,1160,1536,1946,2352,2747,3153,3572,3992,4087,4085,4086,4086,4087,4086,4085,4086,4087,4086,4086,4087,4087,4086,4085,4086,4086,4087,4085,4086,4085,4086,4085,4086,4087,4086,4086,4087,4085,4086,4086,4086,4087,4086,4086,4086,4086,4086,4086,4087,4086,4086,4086,4086,4086,4087,4087,4085,4086,4086,4086,4086,4087,4086,4085,4086,4086,4087,4087,4086,4086,4086,4086,4087,4086,4086,4087,4087,4085,4087,4086,4087,4085,4087,4087,4086,4086,4088,4086,4086,4087,4087,4086,4086,4087,4087,4087,4087,4086,4087,4086,4087,4086,4087,4086,4085,4087,4087,4085,3881,3410,2988,2514,1867,1656,1214,819,616,561,561,529,529,494,503];
a2 = [567,568,577,607,649,868,1181,1574,1998,2409,2822,3234,3691,4085,4086,4085,4087,4086,4085,4087,4087,4086,4087,4086,4087,4087,4087,4085,4087,4088,4085,4086,4086,4087,4086,4086,4086,4086,4088,4087,4086,4086,4086,4086,4086,4085,4086,4085,4086,4087,4086,4085,4086,4087,4085,4087,4086,4087,4086,4086,4086,4086,4087,4087,4087,4086,4086,4086,4087,4086,4086,4085,4087,4085,4086,4086,4086,4086,4087,4088,4087,4086,4086,4087,4086,4086,4086,4087,4086,4086,4086,4086,4086,4087,4086,4087,4086,4088,4085,4086,4086,4086,4087,4087,4087,4085,4086,4086,4086,4086,4086,4086,4085,3844,3358,2941,2469,1842,1636,1193,808,607,551,555,523,523,489,500];
a3 = [570,572,580,608,653,864,1171,1559,1976,2382,2778,3183,3606,4029,4085,4086,4086,4086,4086,4085,4087,4087,4086,4086,4087,4087,4086,4086,4087,4086,4087,4088,4085,4086,4086,4085,4086,4086,4086,4087,4085,4086,4087,4086,4086,4086,4086,4086,4086,4086,4087,4085,4086,4085,4087,4087,4087,4086,4087,4087,4086,4087,4086,4086,4085,4087,4087,4086,4086,4086,4087,4086,4086,4086,4085,4086,4086,4086,4087,4085,4085,4086,4086,4087,4085,4086,4087,4087,4086,4086,4086,4086,4086,4086,4087,4087,4087,4086,4087,4085,4086,4087,4085,4086,4086,4087,4087,4086,4085,4086,4086,4085,4086,3970,3472,3031,2552,1892,1677,1220,812,606,551,551,521,524,488,497];
a4 = [568,568,577,610,652,872,1181,1568,2004,2415,2826,3242,3670,4073,4085,4086,4085,4087,4086,4086,4086,4088,4087,4085,4086,4087,4086,4086,4088,4086,4086,4087,4086,4086,4086,4086,4086,4086,4085,4089,4089,4086,4087,4086,4086,4085,4087,4086,4087,4086,4087,4087,4086,4086,4086,4087,4087,4086,4087,4087,4087,4085,4087,4086,4087,4087,4086,4087,4086,4087,4087,4084,4087,4085,4086,4087,4087,4085,4087,4087,4086,4086,4087,4086,4087,4086,4087,4087,4086,4086,4086,4086,4086,4087,4086,4086,4086,4086,4087,4086,4087,4086,4087,4086,4087,4086,4085,4087,4086,4087,4085,4086,4085,3932,3437,3009,2530,1875,1670,1212,819,610,554,557,525,530,493,503];
a5 = [590,588,596,628,676,904,1233,1644,2087,2512,2934,3371,3819,4086,4086,4085,4087,4086,4087,4086,4087,4087,4086,4086,4087,4086,4085,4090,4086,4086,4086,4087,4087,4085,4087,4087,4086,4086,4086,4086,4085,4087,4086,4087,4085,4086,4086,4087,4086,4086,4087,4085,4086,4087,4086,4086,4086,4084,4086,4085,4087,4086,4085,4086,4087,4087,4085,4088,4086,4086,4086,4086,4083,4086,4084,4086,4086,4087,4087,4087,4086,4086,4086,4086,4086,4085,4086,4086,4086,4087,4087,4086,4086,4086,4085,4087,4086,4086,4086,4085,4086,4086,4086,4086,4086,4086,4086,4086,4085,4085,4086,4086,4086,3838,3355,2939,2481,1840,1631,1190,805,603,548,550,519,523,493,500];
a6 = [551,551,561,589,627,836,1133,1515,1924,2317,2707,3110,3519,3930,4085,4086,4087,4085,4086,4086,4086,4086,4086,4087,4086,4086,4087,4086,4087,4086,4087,4087,4086,4085,4088,4087,4085,4086,4086,4086,4085,4086,4086,4086,4086,4086,4086,4086,4086,4087,4086,4086,4087,4087,4086,4086,4086,4086,4085,4086,4086,4086,4085,4085,4086,4086,4085,4085,4086,4086,4086,4087,4086,4086,4087,4085,4086,4086,4086,4086,4086,4087,4086,4085,4085,4086,4086,4087,4087,4086,4087,4085,4086,4087,4086,4086,4087,4087,4086,4085,4087,4087,4086,4086,4087,4086,4087,4086,4086,4086,4086,4086,4085,3799,3307,2899,2437,1811,1608,1174,793,597,543,543,512,515,479,488];
a7 = [580,581,592,621,668,897,1224,1629,2076,2503,2929,3360,3789,4085,4086,4085,4087,4086,4086,4087,4086,4086,4086,4086,4084,4087,4086,4086,4087,4086,4086,4087,4087,4086,4086,4086,4086,4087,4087,4087,4087,4085,4085,4086,4088,4085,4087,4085,4086,4087,4087,4086,4087,4086,4088,4085,4087,4087,4086,4086,4087,4086,4086,4086,4086,4085,4086,4087,4087,4086,4085,4087,4086,4087,4088,4088,4087,4085,4087,4086,4086,4084,4086,4086,4086,4086,4086,4086,4086,4086,4086,4086,4086,4087,4087,4087,4087,4086,4086,4085,4086,4086,4086,4086,4086,4087,4086,4086,4086,4086,4086,4086,4085,3931,3441,3009,2529,1878,1665,1210,819,612,554,554,524,528,491,499];
a8 = [576,576,586,618,665,894,1215,1627,2072,2498,2948,3388,3832,4085,4086,4086,4086,4086,4086,4087,4085,4085,4086,4086,4086,4087,4086,4087,4087,4086,4086,4086,4086,4086,4087,4087,4085,4086,4087,4086,4086,4086,4087,4087,4086,4086,4087,4084,4087,4086,4086,4085,4087,4086,4086,4086,4086,4086,4086,4086,4086,4087,4085,4087,4086,4086,4087,4086,4087,4087,4086,4085,4087,4086,4086,4087,4086,4087,4086,4086,4087,4086,4086,4086,4086,4086,4086,4086,4086,4086,4086,4086,4086,4087,4086,4086,4086,4087,4086,4086,4085,4088,4086,4086,4086,4087,4086,4087,4087,4087,4086,4087,4086,3892,3402,2982,2502,1856,1647,1201,812,611,557,553,525,530,492,502];
a9 = [576,578,591,616,664,890,1213,1628,2077,2506,2932,3370,3819,4086,4084,4086,4086,4085,4086,4087,4086,4087,4086,4087,4087,4086,4086,4087,4086,4087,4086,4086,4086,4085,4087,4086,4085,4086,4087,4087,4087,4086,4086,4087,4086,4086,4086,4085,4086,4086,4087,4086,4086,4085,4086,4086,4085,4086,4086,4086,4086,4087,4087,4087,4086,4086,4086,4086,4086,4086,4087,4086,4087,4087,4086,4086,4087,4086,4087,4087,4086,4087,4087,4085,4086,4086,4086,4087,4086,4087,4086,4086,4087,4086,4087,4087,4086,4085,4085,4086,4087,4087,4087,4087,4086,4087,4086,4085,4085,4087,4086,4086,4086,3898,3412,2984,2511,1861,1651,1201,810,607,552,552,525,525,491,500];

A = [a1;a2;a3;a4;a5;a6;a7;a8;a9];

stredni_hodnota = median(A);

plot(stredni_hodnota)
%bar(stredni_hodnota, 0.5)
