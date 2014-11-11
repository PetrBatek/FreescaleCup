clear all;
close all;

% data z kamery pri nasmerovani na oranzovou zed, osvetleni zleva.
a1 = [224,222,221,238,239,306,367,463,537,622,682,769,827,912,965,1048,1106,1175,1220,1285,1343,1395,1452,1501,1544,1589,1637,1684,1710,1709,1749,1773,1785,1831,1825,1843,1871,1815,1762,1826,1869,1859,1862,1872,1868,1892,1872,1895,1899,1910,1876,1896,1887,1894,1891,1894,1886,1894,1884,1896,1886,1891,1875,1884,1881,1874,1871,1872,1862,1862,1841,1855,1752,1836,1809,1812,1803,1802,1783,1778,1801,1790,1766,1768,1753,1745,1748,1741,1693,1692,1664,1646,1623,1602,1575,1563,1518,1474,1471,1445,1388,1368,1301,1273,1206,1175,1111,1071,995,968,884,853,770,735,652,609,536,446,406,349,270,240,219,229,209,222,200,215];
a2 = [220,219,221,240,241,309,368,464,538,627,687,772,833,920,973,1058,1118,1183,1230,1296,1357,1408,1462,1514,1557,1599,1646,1695,1721,1718,1761,1781,1794,1835,1831,1855,1878,1822,1768,1834,1881,1867,1875,1881,1883,1902,1888,1909,1911,1921,1891,1910,1897,1909,1909,1911,1909,1913,1902,1914,1906,1910,1895,1904,1899,1896,1891,1887,1885,1881,1860,1875,1769,1851,1827,1833,1823,1820,1807,1800,1819,1807,1783,1784,1775,1763,1768,1759,1716,1714,1681,1663,1637,1617,1591,1581,1537,1487,1488,1460,1405,1379,1315,1287,1218,1186,1120,1081,1009,975,895,859,778,737,656,614,537,448,407,351,271,243,219,230,212,219,200,214];
a3 = [218,221,220,242,241,309,370,461,535,627,686,771,831,915,971,1054,1111,1179,1228,1288,1350,1403,1457,1507,1551,1595,1640,1688,1713,1711,1754,1775,1789,1833,1828,1845,1874,1817,1765,1830,1873,1862,1869,1881,1879,1902,1884,1907,1904,1917,1884,1907,1895,1900,1902,1903,1899,1908,1896,1908,1900,1905,1887,1900,1892,1890,1888,1884,1875,1875,1855,1867,1763,1849,1819,1826,1817,1814,1798,1793,1812,1799,1776,1778,1763,1756,1762,1754,1707,1703,1673,1659,1632,1614,1588,1573,1533,1483,1485,1457,1400,1376,1312,1281,1214,1182,1120,1077,1002,970,892,857,774,736,654,612,536,446,408,348,268,244,219,230,210,219,200,213];
a4 = [219,218,220,239,240,307,367,462,536,625,684,769,829,911,965,1047,1108,1173,1217,1283,1342,1396,1449,1501,1545,1590,1633,1682,1706,1704,1748,1770,1782,1826,1819,1841,1865,1811,1762,1821,1869,1856,1860,1869,1870,1890,1873,1893,1897,1905,1875,1895,1882,1890,1885,1894,1889,1897,1884,1893,1885,1891,1875,1883,1879,1875,1875,1868,1862,1859,1840,1855,1754,1832,1808,1810,1800,1798,1786,1778,1799,1792,1761,1764,1751,1745,1749,1743,1698,1693,1669,1651,1622,1601,1576,1565,1522,1474,1473,1448,1390,1369,1305,1275,1206,1176,1110,1073,998,967,886,851,769,734,651,608,536,445,405,346,271,242,218,228,209,218,200,212];
a5 = [225,221,219,243,241,307,367,462,535,625,684,770,827,913,967,1051,1108,1174,1223,1287,1344,1398,1453,1503,1547,1591,1634,1684,1709,1711,1752,1772,1784,1831,1826,1847,1874,1816,1768,1830,1874,1860,1866,1875,1869,1890,1875,1896,1897,1908,1879,1897,1883,1891,1889,1895,1887,1898,1884,1898,1888,1892,1878,1888,1881,1878,1873,1870,1865,1864,1844,1859,1759,1838,1811,1816,1808,1808,1788,1785,1806,1793,1770,1768,1756,1748,1751,1745,1702,1696,1672,1654,1626,1611,1584,1568,1526,1482,1483,1453,1397,1375,1309,1278,1214,1182,1118,1078,1002,971,890,857,774,735,653,612,533,448,409,348,269,243,218,231,209,223,202,215];
a6 = [218,217,217,225,240,306,368,461,534,624,683,769,827,910,963,1050,1106,1174,1219,1285,1342,1396,1449,1502,1544,1587,1634,1682,1705,1708,1752,1770,1781,1827,1822,1844,1869,1816,1762,1827,1871,1862,1865,1872,1871,1893,1876,1897,1898,1910,1877,1898,1887,1893,1890,1899,1891,1898,1886,1896,1895,1898,1880,1887,1887,1878,1879,1875,1869,1863,1848,1864,1762,1840,1813,1820,1812,1810,1794,1787,1807,1793,1771,1771,1761,1753,1754,1752,1706,1700,1674,1656,1629,1611,1586,1573,1533,1486,1483,1460,1396,1375,1309,1282,1215,1185,1117,1078,1003,972,889,857,776,736,655,613,536,447,408,348,269,242,219,230,209,220,199,215];
a7 = [223,221,219,241,240,306,368,461,534,625,682,770,829,912,967,1051,1107,1173,1219,1284,1343,1393,1450,1501,1543,1588,1633,1682,1709,1708,1750,1769,1781,1826,1826,1844,1868,1817,1766,1830,1874,1862,1865,1875,1874,1893,1880,1899,1897,1910,1876,1901,1886,1895,1895,1898,1892,1902,1887,1898,1890,1895,1879,1886,1882,1880,1875,1872,1865,1864,1845,1859,1757,1839,1811,1814,1805,1804,1793,1784,1808,1793,1771,1770,1757,1748,1751,1745,1700,1698,1670,1651,1628,1610,1580,1572,1525,1482,1481,1453,1398,1375,1308,1279,1212,1181,1115,1078,1002,972,891,859,775,737,655,611,536,445,407,346,271,242,219,229,209,222,201,215];
a8 = [220,221,221,241,236,306,366,461,533,624,681,767,825,910,960,1046,1106,1171,1217,1280,1341,1394,1445,1495,1539,1585,1633,1680,1705,1706,1751,1769,1779,1824,1822,1840,1869,1811,1759,1823,1862,1855,1860,1867,1867,1888,1870,1894,1897,1904,1875,1891,1880,1888,1887,1892,1885,1890,1879,1891,1882,1888,1870,1881,1876,1872,1869,1867,1855,1857,1836,1852,1744,1829,1803,1809,1796,1797,1783,1777,1795,1785,1759,1761,1752,1746,1748,1739,1692,1692,1667,1647,1619,1603,1576,1563,1518,1476,1472,1443,1395,1366,1300,1273,1209,1177,1112,1073,998,968,888,851,771,733,652,611,533,444,405,346,269,239,219,230,212,221,201,213];
a9 = [221,217,219,239,241,307,367,459,532,621,679,763,822,908,956,1042,1099,1164,1211,1277,1335,1388,1442,1494,1536,1580,1621,1675,1700,1702,1744,1763,1777,1819,1815,1833,1864,1800,1751,1814,1858,1844,1851,1859,1856,1876,1863,1881,1880,1895,1864,1883,1870,1876,1875,1879,1871,1881,1869,1881,1874,1878,1863,1868,1867,1865,1860,1858,1852,1847,1828,1847,1744,1826,1799,1801,1795,1794,1777,1771,1793,1778,1757,1757,1748,1740,1746,1735,1693,1689,1665,1644,1620,1602,1573,1563,1520,1477,1476,1447,1390,1366,1300,1280,1207,1175,1111,1073,998,966,885,852,771,731,651,610,534,444,406,347,269,245,219,230,211,219,199,212];
a10 = [222,217,219,243,243,308,367,461,534,623,682,765,822,908,958,1046,1102,1171,1214,1275,1337,1390,1448,1495,1542,1583,1625,1644,1700,1704,1750,1769,1781,1823,1818,1838,1866,1808,1755,1818,1862,1847,1858,1866,1859,1884,1865,1884,1888,1901,1868,1889,1873,1881,1881,1884,1879,1888,1877,1882,1877,1883,1866,1872,1872,1868,1867,1860,1855,1854,1836,1847,1747,1827,1797,1804,1797,1795,1778,1772,1797,1784,1758,1760,1747,1740,1742,1737,1691,1689,1661,1649,1620,1598,1571,1561,1521,1477,1470,1446,1390,1367,1304,1273,1205,1177,1109,1070,998,964,884,853,771,731,652,612,535,444,406,348,270,243,218,230,210,219,202,215];
a11 = [219,218,219,239,239,302,366,459,528,617,679,763,819,902,954,1038,1095,1160,1209,1271,1330,1384,1436,1491,1538,1581,1624,1671,1695,1700,1736,1759,1766,1811,1807,1826,1846,1793,1746,1805,1847,1832,1839,1843,1841,1865,1850,1869,1871,1879,1848,1868,1856,1864,1865,1865,1859,1866,1853,1864,1860,1861,1848,1856,1853,1848,1845,1843,1835,1837,1815,1834,1731,1812,1791,1792,1785,1783,1768,1761,1784,1770,1747,1748,1735,1730,1736,1726,1684,1678,1649,1637,1612,1590,1563,1554,1510,1461,1466,1436,1381,1358,1292,1265,1198,1166,1103,1063,991,961,882,848,764,727,648,606,534,443,404,345,269,241,214,228,207,220,197,214];
a12 = [215,219,220,238,237,307,364,456,511,612,674,756,818,898,950,1033,1093,1159,1203,1269,1328,1384,1437,1485,1527,1572,1617,1663,1687,1689,1724,1745,1754,1802,1789,1812,1834,1781,1730,1794,1832,1823,1829,1836,1836,1857,1839,1858,1858,1869,1839,1859,1843,1850,1851,1856,1845,1854,1841,1854,1846,1847,1836,1847,1842,1837,1837,1834,1828,1829,1811,1826,1725,1804,1777,1778,1774,1773,1758,1750,1773,1760,1741,1738,1731,1722,1728,1719,1672,1670,1646,1630,1602,1585,1558,1546,1503,1454,1459,1429,1374,1353,1285,1258,1192,1164,1098,1061,986,958,878,844,764,722,645,604,529,443,401,345,267,242,218,227,208,221,198,215];

A = [a1;a2;a3;a4;a5;a6;a7;a8;a9;a10;a11;a12];

stredni_hodnota = median(A);

camera_plot_data(stredni_hodnota)