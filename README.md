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

| iwave  | Description              | Parameters     | Data Type | Unit   |
|:-------|:------------------------:|:---------------|:----------|:-------|
| -2     | Direct definition        |<br>1. wavelength inf.<br>2. wavelength sup.<br> step by step output|Integer<br>Float<br>Float<br>|<br>micrometer<br>micrometer<br>|
| -1     | Direct definition        |<br>1. wavelength<br>|Integer<br>Float<br>|<br>micrometer<br>|
|  0     | Direct definition        |<br>1. wavelength inf.<br>2. wavelength sup.<br>|Float<br>Float<br>|micrometer<br>micrometer<br>|
|  1     | Direct definition        |<br>1. wavelength inf.<br>2. wavelength sup.<br>3. Filter function s(lambda) by step of 0.0025 micrometer|Float<br>Float<br>repeat function elements<br>|micrometer<br>micrometer<br>function<br>|
|  2     | Meteosat VIS band        |[0.350-1.110]|Integer<br> |<br>|
|  3     | GOES East VIS band       |[0.490-0.900]|Integer<br> |<br>|
|  4     | GOES West VIS band       |[0.490-0.900]|Integer<br> |<br>|
|  5     | NOAA AVHRR 6 band 1      |[0.550-0.750]|Integer<br> |<br>|
|  6     | NOAA AVHRR 6 band 2      |[0.690-1.120]|Integer<br> |<br>|
|  7     | NOAA AVHRR 7 band 1      |[0.500-0.800]|Integer<br> |<br>|
|  8     | NOAA AVHRR 7 band 2      |[0.640-0.800]|Integer<br> |<br>|
|  9     | NOAA AVHRR 8 band 1      |[0.540-1.010]|Integer<br> |<br>|
| 10     | NOAA AVHRR 8 band 2      |[0.680-1.120]|Integer<br> |<br>|
| 11     | NOAA AVHRR 9 band 1      |[0.530-0.810]|Integer<br> |<br>|
| 12     | NOAA AVHRR 9 band 2      |[0.680-1.170]|Integer<br> |<br>|
| 13     | NOAA AVHRR 10 band 1     |[0.530-0.780]|Integer<br> |<br>|
| 14     | NOAA AVHRR 10 band 2     |[0.600-1.190]|Integer<br> |<br>|
| 15     | NOAA AVHRR 11 band 1     |[0.540-0.820]|Integer<br> |<br>|
| 16     | NOAA AVHRR 11 band 2     |[0.600-1.120]|Integer<br> |<br>|
| 17     | SPOT HRV 1 band 1        |[0.470-0.650]|Integer<br> |<br>|
| 18     | SPOT HRV 1 band 2        |[0.600-0.720]|Integer<br> |<br>|
| 19     | SPOT HRV 1 band 3        |[0.730-0.930]|Integer<br> |<br>|
| 20     | SPOT HRV 1 band pan      |[0.470-0.790]|Integer<br> |<br>|
| 21     | SPOT HRV 2 band 1        |[0.470-0.650]|Integer<br> |<br>|
| 22     | SPOT HRV 2 band 2        |[0.590-0.730]|Integer<br> |<br>|
| 23     | SPOT HRV 2 band 3        |[0.740-0.940]|Integer<br> |<br>|
| 24     | SPOT HRV 2 band pan      |[0.470-0.790]|Integer<br> |<br>|
| 25     | LANDSAT5 TM band 1       |[0.430-0.560]|Integer<br> |<br>|
| 26     | LANDSAT5 TM band 2       |[0.500-0.650]|Integer<br> |<br>|
| 27     | LANDSAT5 TM band 3       |[0.580-0.740]|Integer<br> |<br>|
| 28     | LANDSAT5 TM band 4       |[0.730-0.950]|Integer<br> |<br>|
| 29     | LANDSAT5 TM band 5       |[1.5025-1.890]|Integer<br> |<br>|
| 30     | LANDSAT5 TM band 7       |[1.950-2.410]|Integer<br> |<br>|
| 31     | LANDSAT MSS band 1       |[0.475-0.640]|Integer<br> |<br>|
| 32     | LANDSAT MSS band 2       |[0.580-0.750]|Integer<br> |<br>|
| 33     | LANDSAT MSS band 3       |[0.655-0.855]|Integer<br> |<br>|
| 34     | LANDSAT MSS band 4       |[0.785-1.100]|Integer<br> |<br>|
| 35     | MAS ER2 band 1           |[0.5025-0.5875]|Integer<br> |<br>|
| 36     | MAS ER2 band 2           |[0.6075-0.7000]|Integer<br> |<br>|
| 37     | MAS ER2 band 3           |[0.8300-0.9125]|Integer<br> |<br>|
| 38     | MAS ER2 band 4           |[0.9000-0.9975]|Integer<br> |<br>|
| 39     | MAS ER2 band 5           |[1.8200-1.9575]|Integer<br> |<br>|
| 40     | MAS ER2 band 6           |[2.0950-2.1925]|Integer<br> |<br>|
| 41     | MAS ER2 band 7           |[3.5800-3.8700]|Integer<br> |<br>|
| 42     | MODIS band 1             |[0.6100-0.6850]|Integer<br> |<br>|
| 43     | MODIS band 2             |[0.8200-0.9025]|Integer<br> |<br>|
| 44     | MODIS band 3             |[0.4500-0.4825]|Integer<br> |<br>|
| 45     | MODIS band 4             |[0.5400-0.5700]|Integer<br> |<br>|
| 46     | MODIS band 5             |[1.2150-1.2700]|Integer<br> |<br>|
| 47     | MODIS band 6             |[1.6000-1.6650]|Integer<br> |<br>|
| 48     | MODIS band 7             |[2.0575-2.1825]|Integer<br> |<br>|
| 49     | NOAA AVHRR 12 band 1     |[0.500-1.000]|Integer<br> |<br>|
| 50     | NOAA AVHRR 12 band 2     |[0.650-1.120]|Integer<br> |<br>|
| 51     | NOAA AVHRR 14 band 1     |[0.500-1.110]|Integer<br> |<br>|
| 52     | NOAA AVHRR 14 band 2     |[0.680-1.100]|Integer<br> |<br>|
| 53     | POLDER band 1            |[0.4125-0.4775]|Integer<br> |<br>|
| 54     | POLDER band 2 (non polar)|[0.4100-0.5225]|Integer<br> |<br>|
| 55     | POLDER band 3 (non polar)|[0.5325-0.5950]|Integer<br> |<br>|
| 56     | POLDER band 4 P1         |[0.6300-0.7025]|Integer<br> |<br>|
| 57     | POLDER band 5 (non polar)|[0.7450-0.7800]|Integer<br> |<br>|
| 58     | POLDER band 6 (non polar)|[0.7000-0.8300]|Integer<br> |<br>|
| 59     | POLDER band 7 P1         |[0.8100-0.9200]|Integer<br> |<br>|
| 60     | POLDER band 8 (non polar)|[0.8650-0.9400]|Integer<br> |<br>|
| 61     | SEAWIFS band 1           |[0.3825-0.70]|Integer<br> |<br>|
| 62     | SEAWIFS band 2           |[0.3800-0.58]|Integer<br> |<br>|
| 63     | SEAWIFS band 3           |[0.3800-1.02]|Integer<br> |<br>|
| 64     | SEAWIFS band 4           |[0.3800-1.02]|Integer<br> |<br>|
| 65     | SEAWIFS band 5           |[0.3825-1.15]|Integer<br> |<br>|
| 66     | SEAWIFS band 6           |[0.3825-1.05]|Integer<br> |<br>|
| 67     | SEAWIFS band 7           |[0.3800-1.15]|Integer<br> |<br>|
| 68     | SEAWIFS band 8           |[0.3800-1.15]|Integer<br> |<br>|
| 69     | AATSR band 1             |[0.5250-0.5925]|Integer<br> |<br>|
| 70     | AATSR band 2             |[0.6275-0.6975]|Integer<br> |<br>|
| 71     | AATSR band 3             |[0.8325-0.9025]|Integer<br> |<br>|
| 72     | AATSR band 4             |[1.4475-1.7775]|Integer<br> |<br>|
| 73     | MERIS band 01            |[0.412]|Integer<br> |<br>|
| 74     | MERIS band 02            |[0.442]|Integer<br> |<br>|
| 75     | MERIS band 03            |[0.489]|Integer<br> |<br>|
| 76     | MERIS band 04            |[0.509]|Integer<br> |<br>|
| 77     | MERIS band 05            |[0.559]|Integer<br> |<br>|
| 78     | MERIS band 06            |[0.619]|Integer<br> |<br>|
| 79     | MERIS band 07            |[0.664]|Integer<br> |<br>|
| 80     | MERIS band 08            |[0.681]|Integer<br> |<br>|
| 81     | MERIS band 09            |[0.708]|Integer<br> |<br>|
| 82     | MERIS band 10            |[0.753]|Integer<br> |<br>|
| 83     | MERIS band 11            |[0.760]|Integer<br> |<br>|
| 84     | MERIS band 12            |[0.778]|Integer<br> |<br>|
| 85     | MERIS band 13            |[0.865]|Integer<br> |<br>|
| 86     | MERIS band 14            |[0.885]|Integer<br> |<br>|
| 87     | MERIS band 15            |[0.900]|Integer<br> |<br>|
| 88     | GLI band 1               |[0.380]|Integer<br> |1Km|
| 89     | GLI band 2               |[0.400]|Integer<br> |1Km|
| 90     | GLI band 3               |[0.412]|Integer<br> |1Km|
| 91     | GLI band 4               |[0.443]|Integer<br> |1Km|
| 92     | GLI band 5               |[0.460]|Integer<br> |1Km|
| 93     | GLI band 6               |[0.490]|Integer<br> |1Km|
| 94     | GLI band 7               |[0.520]|Integer<br> |1Km|
| 95     | GLI band 8               |[0.545]|Integer<br> |1Km|
| 96     | GLI band 9               |[0.565]|Integer<br> |1Km|
| 97     | GLI band 10              |[0.625]|Integer<br> |1Km|
| 98     | GLI band 11              |[0.666]|Integer<br> |1Km|
| 99     | GLI band 12              |[0.680]|Integer<br> |1Km|
| 100    | GLI band 13              |[0.678]|Integer<br> |1Km|
| 101    | GLI band 14              |[0.710]|Integer<br> |1Km|
| 102    | GLI band 15              |[0.710]|Integer<br> |1Km|
| 103    | GLI band 16              |[0.749]|Integer<br> |1Km|
| 104    | GLI band 17              |[0.763]|Integer<br> |1Km|
| 105    | GLI band 18              |[0.865]|Integer<br> |1Km|
| 106    | GLI band 19              |[0.865]|Integer<br> |1Km|
| 107    | GLI band 20              |[0.460]|Integer<br> |0.25Km|
| 108    | GLI band 21              |[0.545]|Integer<br> |0.25Km|
| 109    | GLI band 22              |[0.660]|Integer<br> |0.25Km|
| 110    | GLI band 23              |[0.825]|Integer<br> |0.25Km|
| 111    | GLI band 24              |[1.050]|Integer<br> |1Km|
| 112    | GLI band 25              |[1.135]|Integer<br> |1Km|
| 113    | GLI band 26              |[1.240]|Integer<br> |1Km|
| 114    | GLI band 27              |[1.338]|Integer<br> |1Km|
| 115    | GLI band 28              |[1.640]|Integer<br> |1Km|
| 116    | GLI band 29              |[2.210]|Integer<br> |1Km|
| 117    | GLI band 30              |[3.715]|Integer<br> |1Km|
| 118    | ALI band 1p              |[0.4225-0.4625]|Integer<br> ||
| 119    | ALI band 1               |[0.4325-0.550]|Integer<br> ||
| 120    | ALI band 2               |[0.500-0.630]|Integer<br> ||
| 121    | ALI band 3               |[0.5755-0.730]|Integer<br> ||
| 122    | ALI band 4               |[0.7525-0.8375]|Integer<br> ||
| 123    | ALI band 4p              |[0.8025-0.935]|Integer<br> ||
| 124    | ALI band 5p              |[1.130-1.345]|Integer<br> ||
| 125    | ALI band 5               |[1.470-1.820]|Integer<br> ||
| 126    | ALI band 7               |[1.980-2.530]|Integer<br> ||
| 127    | ASTER band 1             |[0.485-0.6425]|Integer<br> ||
| 128    | ASTER band 2             |[0.590-0.730]|Integer<br> ||
| 129    | ASTER band 3n            |[0.720-0.9075]|Integer<br> ||
| 130    | ASTER band 3b            |[0.720-0.9225]|Integer<br> ||
| 131    | ASTER band 4             |[1.570-1.7675]|Integer<br> ||
| 132    | ASTER band 5             |[2.120-2.2825]|Integer<br> ||
| 133    | ASTER band 6             |[2.150-2.295]|Integer<br> ||
| 134    | ASTER band 7             |[2.210-2.390]|Integer<br> ||
| 135    | ASTER band 8             |[2.250-2.440]|Integer<br> ||
| 136    | ASTER band 9             |[2.2975-2.4875]|Integer<br> ||
| 137    | LANDSAT7 ETM band 1      |[0.435-0.52]|Integer<br> ||
| 138    | LANDSAT7 ETM band 2      |[0.5-0.6225]|Integer<br> ||
| 139    | LANDSAT7 ETM band 3      |[0.615-0.7025]|Integer<br> ||
| 140    | LANDSAT7 ETM band 4      |[0.74-0.9125]|Integer<br> ||
| 141    | LANDSAT7 ETM band 5      |[1.51-1.7875]|Integer<br> ||
| 142    | LANDSAT7 ETM band 7      |[2.015-2.3775]|Integer<br> ||
| 143    | HYPBLUE band 1           |[0.4375-0.500]|Integer<br> ||
| 144    | HYPBLUE band 2           |[0.435-0.52]|Integer<br> ||
| 145    | VGT band 1               |[0.4175-0.500]|Integer<br> ||
| 146    | VGT band 2               |[0.5975-0.7675]|Integer<br> ||
| 147    | VGT band 3               |[0.7325-0.9575]|Integer<br> ||
| 148    | VGT band 4               |[1.5225-1.800]|Integer<br> ||
| 149    | VIIRS band M1            |[0.4025-0.4225]|Integer<br> ||
| 150    | VIIRS band M2            |[0.4350-0.4550]|Integer<br> ||
| 151    | VIIRS band M3            |[0.4775-0.4975]|Integer<br> ||
| 152    | VIIRS band M4            |[0.5450-0.5650]|Integer<br> ||
| 153    | VIIRS band M5            |[0.6625-0.6825]|Integer<br> ||
| 154    | VIIRS band M6            |[0.7375-0.7525]|Integer<br> ||
| 155    | VIIRS band M7            |[0.8450-0.8850]|Integer<br> ||
| 156    | VIIRS band M8            |[1.2300-1.2500]|Integer<br> ||
| 157    | VIIRS band M9            |[1.3700-1.3850]|Integer<br> ||
| 158    | VIIRS band M10           |[1.5800-1.6400]|Integer<br> ||
| 159    | VIIRS band M11           |[2.2250-2.2750]|Integer<br> ||
| 160    | VIIRS band M12           |[3.6100-3.7900]|Integer<br> ||
| 161    | VIIRS band I1            |[0.6000-0.6800]|Integer<br> ||
| 162    | VIIRS band I2            |[0.8450-0.8850]|Integer<br> ||
| 163    | VIIRS band I3            |[1.5800-1.6400]|Integer<br> ||
| 164    | VIIRS band I4            |[3.5500-3.9300]|Integer<br> ||
| 165    | LDCM band 1              |[0.4275-0.4575]|Integer<br> ||
| 166    | LDCM band 2              |[0.4375-0.5275]|Integer<br> ||
| 167    | LDCM band 3              |[0.5125-0.6000]|Integer<br> ||
| 168    | LDCM band 4              |[0.6275-0.6825]|Integer<br> ||
| 169    | LDCM band 5              |[0.8300-0.8950]|Integer<br> ||
| 170    | LDCM band 6              |[1.5175-1.6950]|Integer<br> ||
| 171    | LDCM band 7              |[2.0375-2.3500]|Integer<br> ||
| 172    | LDCM band 8              |[0.4875-0.6925]|Integer<br> ||
| 173    | LDCM band 9              |[1.3425-1.4025]|Integer<br> ||
| 174    | MODISkm band 8           |[0.4025-0.4225]|Integer<br> ||
| 175    | MODISkm band 9           |[0.4325-0.4500]|Integer<br> ||
| 176    | MODISkm band 10          |[0.4775-0.4950]|Integer<br> ||
| 177    | MODISkm band 11          |[0.5200-0.5400]|Integer<br> ||
| 178    | MODISkm band 12          |[0.5375-0.5550]|Integer<br> ||
| 179    | MODISkm band 13          |[0.6575-0.6750]|Integer<br> ||
| 180    | MODISkm band 14          |[0.6675-0.6875]|Integer<br> ||
| 181    | MODISkm band 15          |[0.7375-0.7575]|Integer<br> ||
| 182    | MODISkm band 16          |[0.8525-0.8825]|Integer<br> ||
| 183    | MODISkm band 17          |[0.8725-0.9375]|Integer<br> ||
| 184    | MODISkm band 18          |[0.9225-0.9475]|Integer<br> ||
| 185    | MODISkm band 19          |[0.8900-0.9875]|Integer<br> ||
| 186    | CAVIS band 1             |[0.4275-0.4575]|Integer<br> ||
| 187    | CAVIS band 2             |[0.4375-0.5275]|Integer<br> ||
| 188    | CAVIS band 3             |[0.5125-0.6000]|Integer<br> ||
| 189    | CAVIS band 4             |[0.6275-0.6825]|Integer<br> ||
| 190    | CAVIS band 5             |[0.8300-0.8950]|Integer<br> ||
| 191    | CAVIS band 6             |[1.3425-1.4025]|Integer<br> ||
| 192    | CAVIS band 7             |[1.5175-1.6950]|Integer<br> ||
| 193    | CAVIS band 8             |[2.0375-2.3500]|Integer<br> ||
| 194    | CAVIS band 9             |[0.4875-0.6925]|Integer<br> ||
| 195    | CAVIS band 10            |[0.4875-0.6925]|Integer<br> ||
| 196    | CAVIS band 11            |[0.5100-0.6200]|Integer<br> ||
| 197    | DMC band 1               |[0.4875-0.6925]|Integer<br> ||
| 198    | DMC band 2               |[0.6100-0.7100]|Integer<br> ||
| 199    | DMC band 3               |[0.7525-0.9275]|Integer<br> ||

### inhomo: ground reflectance (type)

c  you consider an homogeneous surface:                                c
c     enter - inhomo=0                                                 c
c                you may consider directional surface  effects         c
c                  idirec=0 (no directional effect)                    c
c                          you have to specify the surface reflectance:c
c                          igroun  (see note1) which is uniform and    c
c                          lambertian                                  c
c                  idirec=1 ( directional effect)                      c
c                          you have to specify the brdf of the surface c
c                           for the actual solar illumination you  are c
c                           considering as well as the  for a sun  c
c                           which would be at an angle thetav, in      c
c                           addition you have to give the surface      c
c                           albedo (spherical albedo). you can also    c
c                           select one of the selected model from the  c
c                           ibrdf value (see note2). 3 reflectances    c
c                           are computed, robar,robarp and robard      c
c                                                                      c
c  you consider a non uniform surface, the surface is considered as a  c
c            circular target with a reflectance roc and of radius r    c
c            (expressed in km) within an environment of reflectance    c
c            roe                                                       c
c     enter - inhomo=1, then                                           c
c             igrou1,igrou2,rad                                        c
c                  - the target reflectance :igrou1  (see note1)       c
c                  - the envir. reflectance :igrou2  (see note1)       c
c                  - the target radius in km                           c
c                                                                      c
c                                                                      c
c                            ****tree****                              c
c                                                                      c
c                               inhomo                                 c
c                             /          \                             c
c                            /            \                            c
c                           /              \                           c
c                          /                \                          c
c                 ------- 0 -------       -----1 -----                 c
c                        /               /   \       \                 c
c                    idirec             /     \       \                c
c                    /  \              /       \       \               c
c                   /    \            /         \       \              c
c                  /      \       igrou1       igrou2    rad           c
c                 0        1        roc          roe     f(r)          c
c                /          \                                          c
c               /            \                                         c
c           igroun          ibrdf                                      c
c        (roc = roe)        (roc)                                      c
c                           (robar)                                    c
c                           (robarp)                                   c
c                           (robard)                                   c
c                                                                      c
c                   ground reflectance (spectral variation)            c
c                   ---------------------------------------            c
c note1: values of the reflectance selected by igroun,igrou1 or igrou2 c
c        may correspond to the following cases,                        c
c         0  constant value of ro (or roc,or roe) whatever the wavelen c
c            gth. you enter this constant value of ro (or roc or roe). c
c        -1  you have to enter the value of ro (or roc,or roe) by step c
c            of 0.0025 micron from wlinf to wlsup (if you have used thec
c            satellite bands,see implicit values for these limits).    c
c         1  mean spectral value of green vegetation                   c
c         2  mean spectral value of clear water                        c
c         3  mean spectral value of sand                               c
c         4  mean spectral value of lake water                         c
c                                                                      c
c                       ground reflectance (brdf)                      c
c                       -------------------------                      c
c note2: values of the directional reflectance is assumed spectrally   c
c        independent, so you have to specify, the brdf at the          c
c        wavelength for monochromatic condition of the mean value      c
c        over the spectral band                                        c
c         0  you have to enter the value of ro for sun at thetas by    c
c            step of 10 degrees for zenith view  angles (from 0 to 80  c
c            and the value for 85) and by step of 30 degrees for       c
c            azimuth view angles from 0 to 360 degrees, you have to do c
c            same for a sun which would be at thetav. in addition, the c
c            spherical albedo of the surface has to be specified ,as   c
C            well as the observed reflectance in the selected geometry c
c           rodir(sun zenith,view zenith, relative azimuth).	       c
c		 						                                       c
c        you also may select one of the following models               c
c         1  hapke model                                               c
c             the parameters are: om,af,s0,h                           c
c                    om= albedo                                        c
c                    af=assymetry parameter for the phase function     c
c                    s0=amplitude of hot spot                          c
c                    h=width of the hot spot                           c
c                                                                      c
c         2  verstraete et al. model                                   c
c             the parameters are:                                      c
c                there is three lines of parameters:                   c
c                              line 1 (choice of options)              c
c                              line 2 (structural parameters)          c
c                              line 3 (optical parameters)             c
c                line 1:  opt3 opt4 opt5                               c
c                    opt1=1 parametrized model (see verstraete et al., c
c                           JGR, 95, 11755-11765, 1990)                c
c                    opt2=1 reflectance factor (see pinty et al., JGR, c
c                           95, 11767-11775, 1990)                     c
c                    opt3=0 for given values of kappa (see struc below)c
c                         1 for goudriaan's parameterization of kappa  c
c                         2 for dickinson et al's correction to        c
c                           goudriaan's parameterization of kappa (see c
c                           dickinson et al., agricultural and forest  c
c                           meteorology, 52, 109-131, 1990)            c
c                       ---see the manual for complete references----  c
c                    opt4=0 for isotropic phase function               c
c                         1 for heyney and greensteins' phase function c
c                         2 for legendre polynomial phase function     c 
c                    opt5=0 for single scattering only                 c
c                         1 for dickinson et al. parameterization of   c
c                           multiple scattering                        c
c                line 2:  str1 str2 str3 str4                          c
c                    str1='leaf area density', in m2 m-3               c
c                    str2=radius of the sun flecks on the scatterer (m)c
c                    str3=leaf orientation parameter:                  c
c                         if opt3=0 then str3=kappa1                   c
c                         if opt3=1 or 2  then str3=chil               c
c                    str4=leaf orientation parameter (continued):      c
c                         if opt3=0 then str4=kappa2                   c
c                         if opt3=1 or 2 then str4 is not used         c
c                line 3:  optics1 optics2 optics3                      c
c                    optics1=single scattering albedo, n/d value       c
c                            between 0.0 and 1.0                       c
c                    optics2= phase function parameter:                c
c                         if opt4=0 then this input is not used        c
c                         if opt4=1 then asymmetry factor, n/d value   c
c                                   between -1.0and 1.0                c
c                         if opt4=2 then first coefficient of legendre c
c                                   polynomial                         c
c                    optics3=second coefficient of legendre polynomial c
c                            (if opt4=2)                               c
c                                                                      c
c         3  Roujean et al. model                                      c
c             the parameters are: k0,k1,k2                             c
c                 k0=albedo.                                           c
c                 k1=geometric parameter for hot spot effect           c
c                 k2=geometric parameter for hot spot effect           c
c                                                                      c
c         4  walthall et al. model                                     c
c             the parameters are: a,ap,b,c                             c    
c                 a=term in square ts*tv                               c
c                 ap=term in square ts*ts+tv*tv                        c
c                 b=term in ts*tv*cos(phi) (limacon de pascal)         c
c                 c=albedo                                             c
c                                                                      c
c         5  minnaert model                                            c
c             the parameters are: par1,par2                            c
c                                                                      c
c         6  Ocean                                                     c
c             the parameter are: pws,phi_wind,xsal,pcl                 c
c                 pws=wind speed (in m/s)                              c
c                 phi_wind=azim. of the wind (in degres)               c
c                 xsal=salinity (in ppt) xsal=34.3ppt if xsal<0        c
c                 pcl=pigment concentration (in mg/m3)                 c
c                                                                      c
c         7  Iaquinta and Pinty model                                  c
c             the parameters are:                                      c
c                there is 3 lines of parameters:                       c
c                          line 1: choice of option (pild,pihs)        c
c                          line 2: structural parameters (pxLt,pc)     c
c                          line 3: optical parameters (pRl,pTl,pRs)    c
c                Line 1: pild,pihs                                     c
c                    pild=1  planophile leaf distribution              c 
c                    pild=2  erectophile leaf distribution             c 
c                    pild=3  plagiophile leaf distribution             c 
c                    pild=4  extremophile leaf distribution            c 
c                    pild=5  uniform leaf distribution                 c 
c                                                                      c 
c                    pihs=0  no hot spot                               c 
c                    pihs=1  hot spot                                  c 
c                Line 2: pxLt,pc                                       c
c                    pxLt=Leaf area index [1.,15.]                     c 
c                    pc=Hot spot parameter: 2*r*Lambda [0.,2.]         c
c                Line 3: pRl,pTl,pRs                                   c
c                    pRl=Leaf reflectance  [0.,0.99]                   c 
c                    pTl=Leaf transmitance [0.,0.99]                   c 
c                    pRs=Soil albedo       [0.,0.99]                   c 
c                         NB: pRl+PTl <0.99                            c 
c                                                                      c
c         8  Rahman et al. model                                       c
c             the parameters are: rho0,af,xk                           c
c                 rho0=Intensity of the reflectance of the surface     c
c                      cover, N/D value greater or equal to 0          c
c                 af=Asymmetry factor, N/D value between -1.0 and 1.0  c
c                 xk=Structural parameter of the medium                c
c         9   Kuusk's multispectral CR model                           c
c             Reference:                                               c
c             Kuusk A. A multispectral canopy reflectance model.       c
c             Remote Sens. Environ., 1994, 50:75-82                    c
c                                                                      c
c                                                                      c
c             the parameters are:                                      c
c                                                                      c
c     line 1: structural parameters (ul,eps,thm,sl)                    c
c     line 2: optical parameters (cAB,cW,N,cn,s1)                      c
c                                                                      c
c             ul=LAI     [0.1...10]                                    c
c             eps,thm - LAD parameters                                 c
c             eps [0.0..0.9] thm [0.0..90.0]                           c
c             sl      - relative leaf size  [0.01..1.0]                c
c             cAB     - chlorophyll content, ug/cm^2    [30]           c
c             cW      - leaf water equivalent thickness  [0.01..0.03]  c
c             N       - the effective number of elementary layers      c
c                       inside a leaf   [1.225]                        c
c             cn      - the ratio of refractive indices of the leaf    c
c                       surface wax and internal material  [1.0]       c
c             s1      - the weight of the 1st Price function for the   c
c                       soil reflectance     [0.1..0.8]                c
c        10  MODIS operational BDRF                                    c
c             the parameters are: p1,p2,p3                             c
c                 p1 weight for lambertian kernel                      c
c                 p2 weight for Ross Thick kernel                      c
c                 p3 weight for Li Sparse  kernel                      c
c        11  RossLiMaigan  BDRF  model                                 c
c             the parameters are: p1,p2,p3                             c
c                 p1 weight for lambertian kernel                      c
c                 p2 weight for Ross Thick with Hot Spot kernel        c
c                 p3 weight for Li Sparse  kernel                      c
c**********************************************************************c
