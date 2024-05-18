
igeom: geometrical conditions
=============================
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

