GDAL and 6S
===========

Binding 6sV2.1 to GDAL using libfortrangis and OpenMP

WARNING ! Still in development !

igeom: geometrical conditions
-----------------------------
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


idatm: atmospheric model
------------------------
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

iaer: aerosol model(type) and profile
-------------------------------------
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
| 8     | Multimodal Log-Normal Distribution (up to 4 modes)|rmin, rmax, icp<br>Repeat icp times:<br>1. x1, x2, cij<br>2. rn(l,i),l=1,20<br>|Float, Flaot, Integer<br>Integer (x3)<br>Float (x20)<br>|      |
| 9     | Modified Gamma Distribution|rmin, rmax<br>x1, x2, x3<br>rn(l,1),l=1,20<br>ri(l,1),l=1,20|Float (x2)<br>Integer (x3)<br>Float (x20)<br>Float (x20)|      |
| 10    | Junge Power-Law Distribution|rmin, rmax<br>x1<br>rn(l,1),l=1,20<br>ri(l,1),l=1,20|Float (x2)<br>Integer<br>Float (x20)<br>Float (x20)|      |
| 11    | Sun Photometer Distribution|1. radius<br>2. dV/d(logr)<br>|Float<br>Float<br>|nm<br>cm3/cm2/micron<br>|

iaerp: print output of iaer=[8, 9, 10, 11]
------------------------------------------
| idatm | Description           | Parameters     | Data Type | Unit |
|:------|:---------------------:|:---------------|:----------|:-----|
| 0     | results will not be saved |            |Integer    |      |
| 1     | results will be saved |File input (auto extension .mie)|Character|      |

