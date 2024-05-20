# GDAL and 6S

Binding 6sV2.1 to GDAL using libfortrangis and OpenMP

WARNING ! Still in development !

## Description of the inputs

### igeom: geometrical conditions

| igeom | Description           | Parameters     | Data Type | Unit |
|:------|:---------------------:|:---------------|:----------|:-----|
| 0     | Direct specification  | 1. solar zenith angle<br>2. solar azimuth angle<br>3. satellite zenith angle<br>4. satellite azimuth angle<br>5. month<br>6. day of the month<br>|Float<br>Float<br>Float<br>Float<br>Integer<br>Integer<br>|degrees<br>degrees<br>degrees<br>degrees<br>month<br>day<br>|
| 1     | Meteosat Observation  | 1. month<br>2. day of the month<br>3. decimal hour UTC<br>4. No of Cols (full=5000)<br>5. No of lines (full=2500)<br>|Integer<br>Integer<br>Float<br>Integer<br>Integer<br>|month<br>day<br>time<br>columns<br>rows<br>|
| 2     | GOES East Observation | 1. month<br>2. day of the month<br>3. decimal hour UTC<br>4. No of Cols (full=17000)<br>5. No of lines (full=12000)<br>|Integer<br>Integer<br>Float<br>Integer<br>Integer<br>|month<br>day<br>time<br>columns<br>rows<br>| 
| 3     | GOES West Observation | 1. month<br>2. day of the month<br>3. decimal hour UTC<br>4. No of Cols (full=17000)<br>5. No of lines (full=12000)<br>|Integer<br>Integer<br>Float<br>Integer<br>Integer<br>|month<br>day<br>time<br>columns<br>rows<br>| 
| 4     | AVHRR ( PM NOAA )     | 1. month<br>2. day of the month<br>3. decimal hour UTC<br>4. No of Cols (1-2048)<br>5. Equator ascendant node longitude (xlonan)<br>6. Equator ascendant node overpass hour (hna)<br>|Integer<br>Integer<br>Float<br>Integer<br>Float<br>Float<br>|month<br>day<br>time<br>columns<br>longitude<br>time<br>| 
| 5     | AVHRR ( AM NOAA )     | 1. month<br>2. day of the month<br>3. decimal hour UTC<br>4. No of Cols (1-2048)<br>5. Equator ascendant node longitude (xlonan)<br>6. Equator ascendant node overpass hour (hna)<br>|Integer<br>Integer<br>Float<br>Integer<br>Float<br>Float<br>|month<br>day<br>time<br>columns<br>degrees<br>time<br>| 
| 6     | HRV ( SPOT )          | 1. month<br>2. day of the month<br>3. decimal hour UTC<br>4. Central scene pixel longitude<br>5. Central scene pixel latitude<br>|Integer<br>Integer<br>Float<br>Float<br>Float<br>|month<br>day<br>time<br>degrees<br>degrees<br>| 
| 7     | TM ( LANDSAT )        | 1. month<br>2. day of the month<br>3. decimal hour UTC<br>4. Central scene pixel longitude<br>5. Central scene pixel latitude<br>|Integer<br>Integer<br>Float<br>Float<br>Float<br>|month<br>day<br>time<br>degrees<br>degrees<br>| 


### idatm: atmospheric model

| idatm | Description           | Parameters     | Data Type | Unit |
|:------|:---------------------:|:---------------|:----------|:-----|
| 0     | no gaseous absorption |                |Integer    |      |
| 1     | tropical              |                |Integer    |      |
| 2     | midlatitude summer    |                |Integer    |      |
| 3     | midlatitude winter    |                |Integer    |      |
| 4     | subarctic summer      |                |Integer    |      |
| 5     | subarctic winter      |                |Integer    |      |
| 6     | us standard 62        |                |Integer    |      |
| 7     | Direct specification  |File input repeat:<br>1. Altitude<br>2. pressure<br>3. temperature<br>4. H20 density<br>5. O3 density<br>34 layers|<br>Float<br>Float<br>Float<br>Float<br>Float<br>|<br>Km<br>mbar<br>K<br>g/m3<br>g/m3<br>|
| 8     | Direct specification  |1. water vapour (uw)<br>2. Ozone contents (uo3)<br>profile taken from us62<br>|Float<br>Float<br><br>|g/cm2<br>cm-atm<br><br>|

### iaer: aerosol model(type) and profile

| iaer  | Description           | Parameters     | Data Type | Unit |
|:------|:---------------------:|:---------------|:----------|:-----|
| -1    | Direct specification  |File input:<br>total number of layers<br>Repeat per layer:<br>1. altitude<br>2. AOD at 550nm<br>3. type of aerosol (1.dust-like;2.water-soluble;3.oceanic;4.soot)<br>|<br>Integer<br><br>Float<br>Float<br>Integer<br>|<br><br><br>Km<br>Km<br>|
| 0     | no aerosols           |                |Integer    |      |
| 1     | continental           |                |Integer    |      |
| 2     | maritime              |                |Integer    |      |
| 3     | urban                 |                |Integer    |      |
| 4     | Define the volumetric percentage of each component|File input:<br>1. dust-like<br>2. water-soluble<br>3. oceanic<br>4. soot<br>|<br>Float<br>Float<br>Float<br>Float<br>|<br>[0.0-1.0]<br>[0.0-1.0]<br>[0.0-1.0]<br>[0.0-1.0]<br>|
| 5     | background desert     |                |Integer    |      |
| 6     | biomass burning       |                |Integer    |      |
| 7     | stratospheric         |                |Integer    |      |
| 8     | Multimodal Log-Normal Distribution (up to 4 modes)|File input:<br>rmin, rmax, icp<br>Repeat icp times:<br>1. x1, x2, cij<br>2. rn(l,i),l=1,20<br>|<br>Float (x2), Integer<br>Integer (x3)<br>Float (x20)<br>|      |
| 9     | Modified Gamma Distribution|rmin, rmax<br>x1, x2, x3<br>rn(l,1),l=1,20<br>ri(l,1),l=1,20|Float (x2)<br>Integer (x3)<br>Float (x20)<br>Float (x20)|      |
| 10    | Junge Power-Law Distribution|rmin, rmax<br>x1<br>rn(l,1),l=1,20<br>ri(l,1),l=1,20|Float (x2)<br>Integer<br>Float (x20)<br>Float (x20)|      |
| 11    | Sun Photometer Distribution|1. radius<br>2. dV/d(logr)<br>|Float<br>Float<br>|nm<br>cm3/cm2/micron<br>|

### iaerp: print output of iaer=[8, 9, 10, 11]

| iaerp | Description           | Parameters     | Data Type | Unit |
|:------|:---------------------:|:---------------|:----------|:-----|
| 0     | results will not be saved |            |Integer    |      |
| 1     | results will be saved |File input (auto extension .mie)|Character|      |

### taer55: aerosol optical depth at 550nm, only for iaer = [1, 2, 3, 5, 6, 7], iaer_prof=0

| taer55 | Description           | Parameters     | Data Type | Unit |
|:-------|:---------------------:|:---------------|:----------|:-----|
| V      | Direct estimate of the Visibility  |1. Visibility<br>2. aodat550nm not used<br> | Float<br>Float | Km<br>Km<br>|
| taer55 | Direct estimate of the AOD at 550nm |1. Visibility=0<br>2. aodat550nm<br> | Float<br>Float | Km<br>Km<br>|
| V      | Not used |1. Visibility=-1<br>2. aodat550nm not used.<br>|Float<br>Float<br>| Km<br>Km<br>|

### xps: defining target pressure or target height (only one should be != 0)

targetaltitude is the DEM/DSM value

| xps   | Description           | Parameters     | Data Type | Unit   |
|:------|:---------------------:|:---------------|:----------|:-------|
| >= 0  | Direct estimate of the pressure |targetpressure|Float    |millibar|
| < 0   | Direct estimate of the altitude |targetaltitude|Float    |Km      | 

### xpp: defining the sensor altitude

| xpp    | Description           | Parameters     | Data Type | Unit   |
|:-------|:---------------------:|:---------------|:----------|:-------|
| -1000  | Sensor is on-board a satellite |sensoraltitude|Float|Km     |
| -100-0 | Sensor is on-board an aircraft |1. sensoraltitude<br>2. water vapor content<br>3. ozone content<br>4. aodat550nm<br>if 2,3,4 <0, then us62 estimates|Float|Km<br>?<br>?<br>Km<br>|
|  0     | Sensor is at ground level |sensoraltitude|Float    |Km      | 

### iwave: input of the spectral conditions

| iwave  | Description           | Parameters     | Data Type | Unit   |
|:-------|:---------------------:|:---------------|:----------|:-------|
| -2     | Direct definition     |<br>1. wavelength inf.<br>2. wavelength sup.<br> step by step output|Integer<br>Float<br>Float<br>|<br>micrometer<br>micrometer<br>|
| -1     | Direct definition     |<br>1. wavelength<br>|Integer<br>Float<br>|<br>micrometer<br>|
|  0     | Direct definition     |<br>1. wavelength inf.<br>2. wavelength sup.<br>|Float<br>Float<br>|micrometer<br>micrometer<br>|
|  1     | Direct definition     |<br>1. wavelength inf.<br>2. wavelength sup.<br>3. Filter function s(lambda) by step of 0.0025 micrometer|Float<br>Float<br>repeat function elements<br>|micrometer<br>micrometer<br>function<br>|
|  2     | Meteosat VIS band     |[0.350-1.110]|Integer<br> |<br>|
|  3     | GOES East VIS band    |[0.490-0.900]|Integer<br> |<br>|
|  4     | GOES West VIS band    |[0.490-0.900]|Integer<br> |<br>|
|  5     | NOAA AVHRR 6 band 1   |[0.550-0.750]|Integer<br> |<br>|
|  6     | NOAA AVHRR 6 band 2   |[0.690-1.120]|Integer<br> |<br>|
|  7     | NOAA AVHRR 7 band 1   |[0.500-0.800]|Integer<br> |<br>|
|  8     | NOAA AVHRR 7 band 2   |[0.640-0.800]|Integer<br> |<br>|
|  9     | NOAA AVHRR 8 band 1   |[0.540-1.010]|Integer<br> |<br>|
| 10     | NOAA AVHRR 8 band 2   |[0.680-1.120]|Integer<br> |<br>|
| 11     | NOAA AVHRR 9 band 1   |[0.530-0.810]|Integer<br> |<br>|
| 12     | NOAA AVHRR 9 band 2   |[0.680-1.170]|Integer<br> |<br>|
| 13     | NOAA AVHRR 10 band 1  |[0.530-0.780]|Integer<br> |<br>|
| 14     | NOAA AVHRR 10 band 2  |[0.600-1.190]|Integer<br> |<br>|
| 15     | NOAA AVHRR 11 band 1  |[0.540-0.820]|Integer<br> |<br>|
| 16     | NOAA AVHRR 11 band 2  |[0.600-1.120]|Integer<br> |<br>|
| 17     | SPOT HRV 1 band 1     |[0.470-0.650]|Integer<br> |<br>|
| 18     | SPOT HRV 1 band 2     |[0.600-0.720]|Integer<br> |<br>|
| 19     | SPOT HRV 1 band 3     |[0.730-0.930]|Integer<br> |<br>|
| 20     | SPOT HRV 1 band pan   |[0.470-0.790]|Integer<br> |<br>|
| 21     | SPOT HRV 2 band 1     |[0.470-0.650]|Integer<br> |<br>|
| 22     | SPOT HRV 2 band 2     |[0.590-0.730]|Integer<br> |<br>|
| 23     | SPOT HRV 2 band 3     |[0.740-0.940]|Integer<br> |<br>|
| 24     | SPOT HRV 2 band pan   |[0.470-0.790]|Integer<br> |<br>|
| 25     | LANDSAT5 TM band 1    |[0.430-0.560]|Integer<br> |<br>|
| 26     | LANDSAT5 TM band 2    |[0.500-0.650]|Integer<br> |<br>|
| 27     | LANDSAT5 TM band 3    |[0.580-0.740]|Integer<br> |<br>|
| 28     | LANDSAT5 TM band 4    |[0.730-0.950]|Integer<br> |<br>|
| 29     | LANDSAT5 TM band 5    |[1.5025-1.890]|Integer<br> |<br>|
| 30     | LANDSAT5 TM band 7    |[1.950-2.410]|Integer<br> |<br>|
| 31     | LANDSAT MSS band 1    |[0.475-0.640]|Integer<br> |<br>|
| 32     | LANDSAT MSS band 2    |[0.580-0.750]|Integer<br> |<br>|
| 33     | LANDSAT MSS band 3    |[0.655-0.855]|Integer<br> |<br>|
| 34     | LANDSAT MSS band 4    |[0.785-1.100]|Integer<br> |<br>|
| 35     | MAS ER2 band 1        |[0.5025-0.5875]|Integer<br> |<br>|
| 36     | MAS ER2 band 2        |[0.6075-0.7000]|Integer<br> |<br>|
| 37     | MAS ER2 band 3        |[0.8300-0.9125]|Integer<br> |<br>|
| 38     | MAS ER2 band 4        |[0.9000-0.9975]|Integer<br> |<br>|
| 39     | MAS ER2 band 5        |[1.8200-1.9575]|Integer<br> |<br>|
| 40     | MAS ER2 band 6        |[2.0950-2.1925]|Integer<br> |<br>|
| 41     | MAS ER2 band 7        |[3.5800-3.8700]|Integer<br> |<br>|
| 42     | MODIS band 1          |[0.6100-0.6850]|Integer<br> |<br>|
| 43     | MODIS band 2          |[0.8200-0.9025]|Integer<br> |<br>|
| 44     | MODIS band 3          |[0.4500-0.4825]|Integer<br> |<br>|
| 45     | MODIS band 4          |[0.5400-0.5700]|Integer<br> |<br>|
| 46     | MODIS band 5          |[1.2150-1.2700]|Integer<br> |<br>|
| 47     | MODIS band 6          |[1.6000-1.6650]|Integer<br> |<br>|
| 48     | MODIS band 7          |[2.0575-2.1825]|Integer<br> |<br>|
| 49     | NOAA AVHRR 12 band 1  |[0.500-1.000]|Integer<br> |<br>|
| 50     | NOAA AVHRR 12 band 2  |[0.650-1.120]|Integer<br> |<br>|
| 51     | NOAA AVHRR 14 band 1  |[0.500-1.110]|Integer<br> |<br>|
| 52     | NOAA AVHRR 14 band 2  |[0.680-1.100]|Integer<br> |<br>|
| 53     | POLDER band 1         |[0.4125-0.4775]|Integer<br> |<br>|
| 54     | POLDER band 2 (non polar)|[0.4100-0.5225]|Integer<br> |<br>|
| 55     | POLDER band 3 (non polar)|[0.5325-0.5950]|Integer<br> |<br>|
| 56     | POLDER band 4 P1      |[0.6300-0.7025]|Integer<br> |<br>|
| 57     | POLDER band 5 (non polar)|[0.7450-0.7800]|Integer<br> |<br>|
| 58     | POLDER band 6 (non polar)|[0.7000-0.8300]|Integer<br> |<br>|
| 59     | POLDER band 7 P1      |[0.8100-0.9200]|Integer<br> |<br>|
| 60     | POLDER band 8 (non polar)|[0.8650-0.9400]|Integer<br> |<br>|
| 61     | SEAWIFS band 1        |[0.3825-0.70]|Integer<br> |<br>|
| 62     | SEAWIFS band 2        |[0.3800-0.58]|Integer<br> |<br>|
| 63     | SEAWIFS band 3        |[0.3800-1.02]|Integer<br> |<br>|
| 64     | SEAWIFS band 4        |[0.3800-1.02]|Integer<br> |<br>|
| 65     | SEAWIFS band 5        |[0.3825-1.15]|Integer<br> |<br>|
| 66     | SEAWIFS band 6        |[0.3825-1.05]|Integer<br> |<br>|
| 67     | SEAWIFS band 7        |[0.3800-1.15]|Integer<br> |<br>|
| 68     | SEAWIFS band 8        |[0.3800-1.15]|Integer<br> |<br>|
| 69     | AATSR band 1          |[0.5250-0.5925]|Integer<br> |<br>|
| 70     | AATSR band 2          |[0.6275-0.6975]|Integer<br> |<br>|
| 71     | AATSR band 3          |[0.8325-0.9025]|Integer<br> |<br>|
| 72     | AATSR band 4          |[1.4475-1.7775]|Integer<br> |<br>|
| 73     | MERIS band 01         |[0.412]|Integer<br> |<br>|
| 74     | MERIS band 02         |[0.442]|Integer<br> |<br>|
| 75     | MERIS band 03         |[0.489]|Integer<br> |<br>|
| 76     | MERIS band 04         |[0.509]|Integer<br> |<br>|

c        76  MERIS   band 04           ( 0.509)                        c
c        77  MERIS   band 05           ( 0.559)                        c
c        78  MERIS   band 06           ( 0.619)                        c
c        79  MERIS   band 07           ( 0.664)                        c
c        80  MERIS   band 08           ( 0.681)                        c
c        81  MERIS   band 09           ( 0.708)                        c
c        82  MERIS   band 10          ( 0.753)                         c
c        83  MERIS   band 11          ( 0.760)                         c
c        84  MERIS   band 12          ( 0.778)                         c
c        85  MERIS   band 13          ( 0.865)                         c
c        86  MERIS   band 14          ( 0.885)                         c
c        87  MERIS   band 15          ( 0.900)                         c
c        88  GLI     band 1           (0.380-1km)                      c
c        89  GLI     band 2           (0.400-1km)                      c
c        90  GLI     band 3           (0.412-1km)                      c
c        91  GLI     band 4           (0.443-1km)                      c
c        92  GLI     band 5           (0.460-1km)                      c
c        93  GLI     band 6           (0.490-1km)                      c
c        94  GLI     band 7           (0.520-1km)                      c
c        95  GLI     band 8           (0.545-1km)                      c
c        96  GLI     band 9           (0.565-1km)                      c
c        97  GLI     band 10          (0.625-1km)                      c
c        98  GLI     band 11          (0.666-1km)                      c
c        99  GLI     band 12          (0.680-1km)                      c
c       100  GLI     band 13          (0.678-1km)                      c
c       101  GLI     band 14          (0.710-1km)                      c
c       102  GLI     band 15          (0.710-1km)                      c
c       103  GLI     band 16          (0.749-1km)                      c
c       104  GLI     band 17          (0.763-1km)                      c
c       105  GLI     band 18          (0.865-1km)                      c
c       106  GLI     band 19          (0.865-1km)                      c
c       107  GLI     band 20          (0.460-0.25km)                   c
c       108  GLI     band 21          (0.545-0.25km)                   c
c       109  GLI     band 22          (0.660-0.25km)                   c
c       110  GLI     band 23          (0.825-0.25km)                   c
c       111  GLI     band 24          (1.050-1km)                      c
c       112  GLI     band 25          (1.135-1km)                      c
c       113  GLI     band 26          (1.240-1km)                      c
c       114  GLI     band 27          (1.338-1km)                      c
c       115  GLI     band 28          (1.640-1km)                      c
c       116  GLI     band 29          (2.210-1km)                      c
c       117  GLI     band 30          (3.715-1km)                      c
c       118  ALI     band 1p          (0.4225-0.4625)                  c
c       119  ALI     band 1           (0.4325-0.550)                   c
c       120  ALI     band 2           (0.500-0.630)                    c
c       121  ALI     band 3           (0.5755-0.730)                   c
c       122  ALI     band 4           (0.7525-0.8375)                  c
c       123  ALI     band 4p          (0.8025-0.935)                   c         
c       124  ALI     band 5p          (1.130-1.345)                    c
c       125  ALI     band 5           (1.470-1.820)                    c         
c       126  ALI     band 7           (1.980-2.530)                    c         
c       127  ASTER   band 1           (0.485-0.6425)                   c
c       128  ASTER   band 2           (0.590-0.730)                    c
c       129  ASTER   band 3n          (0.720-0.9075)                   c
c       130  ASTER   band 3b          (0.720-0.9225)                   c
c       131  ASTER   band 4           (1.570-1.7675)                   c
c       132  ASTER   band 5           (2.120-2.2825)                   c
c       133  ASTER   band 6           (2.150-2.295)                    c
c       134  ASTER   band 7           (2.210-2.390)                    c
c       135  ASTER   band 8           (2.250-2.440)                    c
c       136  ASTER   band 9           (2.2975-2.4875)                  c
c       137  ETM     band 1           (0.435-0.52) 		       c         
c       138  ETM     band 2           (0.5-0.6225)                     c
c       139  ETM     band 3           (0.615-0.7025)                   c
c       140  ETM     band 4           (0.74-0.9125)                    c
c       141  ETM     band 5           (1.51-1.7875)                    c
c       142  ETM     band 7           (2.015-2.3775)                   c
c       143  HYPBLUE band 1           (0.4375-0.500)                   c
c       144  HYPBLUE band 2           (0.435-0.52)                     c
c       145  VGT     band 1           (0.4175-0.500)                   c
c       146  VGT     band 2           (0.5975-0.7675)                  c
c       147  VGT     band 3           (0.7325-0.9575)                  c
c       148  VGT     band 4           (1.5225-1.800)                   c
c       149  VIIRS   band M1          (0.4025-0.4225)                  c
c       150  VIIRS   band M2          (0.4350-0.4550)                  c 
c       151  VIIRS   band M3          (0.4775-0.4975)                  c 
c       152  VIIRS   band M4          (0.5450-0.5650)                  c 
c       153  VIIRS   band M5          (0.6625-0.6825)                  c 
c       154  VIIRS   band M6          (0.7375-0.7525)                  c 
c       155  VIIRS   band M7          (0.8450-0.8850)                  c 
c       156  VIIRS   band M8          (1.2300-1.2500)                  c 
c       157  VIIRS   band M9          (1.3700-1.3850)                  c 
c       158  VIIRS   band M10         (1.5800-1.6400)                  c 
c       159  VIIRS   band M11         (2.2250-2.2750)                  c
c       160  VIIRS   band M12         (3.6100-3.7900)                  c 
c       161  VIIRS   band I1          (0.6000-0.6800)                  c 
c       162  VIIRS   band I2          (0.8450-0.8850)                  c 
c       163  VIIRS   band I3          (1.5800-1.6400)                  c 
c       164  VIIRS   band I4          (3.5500-3.9300)                  c
c       165  LDCM    band 1          (0.4275-0.4575)                   c
c       166  LDCM    band 2          (0.4375-0.5275)                   c
c       167  LDCM    band 3          (0.5125-0.6000)                   c
c       168  LDCM    band 4          (0.6275-0.6825)                   c
c       169  LDCM    band 5          (0.8300-0.8950)                   c
c       170  LDCM    band 6          (1.5175-1.6950)                   c
c       171  LDCM    band 7          (2.0375-2.3500)                   c
c       172  LDCM    band 8          (0.4875-0.6925)                   c
c       173  LDCM    band 9          (1.3425-1.4025)                   c
c       174  MODISkm band 8          (0.4025-0.4225)                   c
c       175  MODISkm band 9          (0.4325-0.4500)                   c
c       176  MODISkm band 10         (0.4775-0.4950)                   c
c       177  MODISkm band 11         (0.5200-0.5400)                   c
c       178  MODISkm band 12         (0.5375-0.5550)                   c
c       179  MODISkm band 13         (0.6575-0.6750)                   c
c       180  MODISkm band 14         (0.6675-0.6875)                   c
c       181  MODISkm band 15         (0.7375-0.7575)                   c
c       182  MODISkm band 16         (0.8525-0.8825)                   c
c       183  MODISkm band 17         (0.8725-0.9375)                   c
c       184  MODISkm band 18         (0.9225-0.9475)                   c
c       185  MODISkm band 19         (0.8900-0.9875)                   c
c       186  CAVIS   band 1          (0.4275-0.4575)                   c
c       187  CAVIS   band 2          (0.4375-0.5275)                   c
c       188  CAVIS   band 3          (0.5125-0.6000)                   c
c       189  CAVIS   band 4          (0.6275-0.6825)                   c
c       190  CAVIS   band 5          (0.8300-0.8950)                   c
c       191  CAVIS   band 6          (1.3425-1.4025)                   c
c       192  CAVIS   band 7          (1.5175-1.6950)                   c
c       193  CAVIS   band 8          (2.0375-2.3500)                   c
c       194  CAVIS   band 9          (0.4875-0.6925)                   c
c       195  CAVIS   band 10         (0.4875-0.6925)                   c
c       196  CAVIS   band 11         (0.5100-0.6200)                   c
c       197  DMC     band 1          (0.4875-0.6925)                   c
c       198  DMC    band 2           (0.6100-0.7100)                   c
c       199  DMC    band 3           (0.7525-0.9275)                   c
c  note: wl has to be in micrometer                                    c
c**********************************************************************c
