% idealne bily povrch a idealne cerne postrani cary, lehce horsi osviceni,
% uhel proti plose je priblizne 90 stupnu

% vzdalenost car 10cm, tloustka cary 1.5cm
% kamera nad levou carou

clear all;
close all;

a1 = [229,227,229,253,255,325,396,502,585,686,756,852,923,1018,1085,1176,1251,1329,1384,1463,1535,1600,1663,1725,1783,1837,1900,1955,1990,1992,2049,2068,2090,2142,2146,2171,2204,2139,2086,2162,2217,2203,2217,2225,2230,2259,2246,2265,2223,2141,1987,1890,1745,1637,1566,1532,1513,1515,1508,1548,1565,1640,1738,1880,2010,2121,2215,2275,2282,2275,2245,2258,2131,2229,2197,2200,2187,2186,2172,2163,2197,2180,2154,2150,2142,2129,2121,2047,1915,1817,1683,1557,1454,1382,1302,1261,1203,1169,1184,1274,1370,1482,1527,1556,1486,1443,1370,1316,1224,1182,1084,1036,932,879,781,720,627,507,457,378,280,242,220,231,210,223,204,217];
a2 = [227,227,228,251,253,325,398,502,588,687,759,853,926,1020,1087,1181,1254,1330,1392,1469,1538,1601,1670,1730,1787,1840,1902,1956,1993,1996,2050,2074,2094,2149,2152,2174,2209,2147,2088,2165,2224,2209,2220,2232,2236,2262,2251,2268,2223,2140,1987,1892,1741,1637,1569,1539,1519,1522,1515,1548,1571,1641,1745,1886,2021,2131,2225,2281,2288,2278,2251,2261,2137,2229,2200,2200,2190,2194,2175,2168,2197,2181,2151,2153,2140,2129,2123,2051,1918,1823,1686,1558,1456,1378,1306,1258,1201,1169,1183,1277,1370,1483,1525,1558,1484,1445,1370,1316,1229,1185,1087,1035,938,881,781,722,627,509,457,378,284,241,222,230,212,223,203,217];
a3 = [228,229,230,249,252,328,399,505,586,688,758,854,927,1022,1089,1183,1257,1333,1394,1472,1545,1607,1677,1734,1792,1848,1907,1965,2000,2004,2059,2080,2103,2152,2157,2181,2217,2155,2098,2170,2230,2212,2226,2239,2243,2271,2257,2269,2213,2131,1976,1879,1731,1628,1564,1540,1523,1524,1519,1560,1583,1657,1762,1904,2035,2143,2237,2287,2285,2276,2254,2265,2135,2235,2203,2204,2195,2195,2175,2171,2202,2182,2159,2154,2144,2130,2116,2040,1905,1809,1669,1545,1449,1375,1302,1254,1199,1174,1193,1293,1385,1499,1540,1562,1484,1448,1369,1318,1228,1184,1086,1036,935,879,782,720,626,511,459,379,282,245,219,230,212,225,204,218];
a4 = [230,232,230,248,254,325,400,503,587,689,761,857,927,1020,1089,1187,1259,1336,1394,1470,1545,1607,1676,1735,1794,1842,1906,1966,2001,2005,2057,2082,2103,2154,2156,2178,2218,2153,2094,2174,2233,2218,2227,2240,2246,2272,2261,2272,2216,2131,1971,1873,1723,1619,1561,1535,1521,1525,1522,1565,1589,1672,1788,1928,2054,2162,2254,2297,2293,2284,2257,2268,2139,2239,2208,2205,2196,2194,2178,2169,2203,2184,2157,2157,2147,2131,2116,2038,1905,1808,1668,1545,1448,1377,1300,1255,1200,1172,1193,1294,1386,1503,1542,1560,1487,1447,1367,1317,1225,1184,1081,1037,937,883,783,721,629,509,460,379,279,245,219,229,211,223,203,220];

A = [a1;a2;a3;a4];

stredni_hodnota = median(A);

camera_plot_data(stredni_hodnota);
