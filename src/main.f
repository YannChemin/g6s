! Example program to load a raster file with fortrangis     
      program g6s
        ! Default Fortran 2018 include
        use, intrinsic :: iso_fortran_env, only: int32, real32
        ! Include GDAL FortranGIS bindings
        use gdal
        ! Include C Fortran GIS bindings
        use fortranc
        ! Default to none
        implicit none
        ! Declare argc, argv
        integer :: arg_len, stat
        character(len=:), allocatable :: arg_str
        ! Declare iterator
        integer(int32) :: i, j
        ! Declare allocatable array for pixel storage
        real(kind=c_double), allocatable, target, dimension(:,:) :: array
        ! Declare pointer to array
        type(c_ptr) :: a_ptr
        ! Declare placeholder for length of array
        integer(int32) :: len_array
        ! Declare nrows and ncols placeholders from the raster image
        integer(kind=c_int) :: band, nbands, nrows, ncols, offrow, offcol
        ! Garbage collection
        integer(kind=c_int) :: err ! CPLErr
    
        ! Create a GDAL dataset handle
        type(GDALDataSetH) :: ds, dsOut
        ! Create a GDAL band handle
        type(GDALRasterBandH) :: bandH, OutbandH
        ! Create a GDAL driver handle
        type(GDALDriverH) :: hDriver
        ! Allocate metadata pointer (libfortrangis?)
        type(c_ptr_ptr) :: meta

        ! INPUT/OUTPUT to 6s
        ! The INPUT pixel reflectance
        real      :: inputpixelvalue

        ! Geometric conditions
        ! 0=self-defined
        ! 1=Meteosat, 2=GOES East, 3=GOES West, 4=AVHRR (PM), 5=AVHRR (AM)
        ! 6=HRV (SPOT), 7=TM (Landsat), >7 Undefined yet
        integer   :: inputgeometrycode
        ! if igeom=0, define sunza, sunazim, satza, satazim in degrees
        real      :: solarzenithangledeg, solarazimuthangledeg
        real      :: satellitezenithangledeg, satelliteazimuthangledeg
        ! in all cases, define the month and the day of the month
        integer   :: monthnumber, dayofthemonth
        ! if igeom != 0, define the decimal hour of sat overpass in UTC hh.ddd
        real      :: dechourutchhddd
        ! if igeom == 1, 2 (3: only ncols), specify number of rows and columns
        integer   :: numberofcolumns, numberofrows
        ! if igeom == 4, 5, specify long and hour of equatorial crossing
        real      :: equatorcrossingascendantlongitude
        real      :: equatorcrossingascendantdechour
        ! if igeom == 6, 7, specify the long and lat of central pixel
        real      :: centralpixellongitude, centralpixellatitude
        
        ! Define the variable incoming for atmosphere definition
        integer   :: inputatmosphereidcode
        ! This is only for idatm = 7, radiosonde 34 levels data
        character(len=100) :: filenameradiosonde34
        ! This is only for idatm = 8, H2O and O3 contents (assumes us62 base)
        real      :: watercontent, ozonecontent

        ! Define the variable incoming for aerosols definition
        integer   :: inputaerosolidcode
        ! This is only for iaer = 4, input filename with 4 volumetric parts
        character(len=100) :: filenameaerosolvol

        ! The OUTPUT pixel reflectance
        real :: outputpixelreflectance

        ! Start loading Raster Data

        ! Load GDAL constants and drivers definitions
        call gdalallregister()

        ! Get length of command-line argument
        call get_command_argument(1, length=arg_len)
    
        ! Allocate character string to hold argument
        allocate(character(len=arg_len) :: arg_str)
    
        ! Get command-line argument (number 1 is input file)
        call get_command_argument(1, arg_str)

        ! Open raster file from argument
        ds = gdalopen(TRIM(arg_str)//CHAR(0), GA_ReadOnly)

        ! Get the raster input file driver info
        hDriver = GDALGetDatasetDriver(ds)
    
        ! Get command-line argument (number 2 is output file) 
        call get_command_argument(2, arg_str)

        ! Create an output copy
        dsOut = GDALCreateCopy(hDriver, TRIM(arg_str)//CHAR(0), ds, 0, c_null_ptr, c_null_ptr, c_null_ptr)

        ! Extract metadata information
        meta = c_ptr_ptr_new(GDALGetMetadata(gdalmajorobjecth_new(ds), CHAR(0)))

        ! Print the metadata content to stdout
        do i = 1, c_ptr_ptr_getsize(meta)
            write(*,'(I4,A)') i,TRIM(strtofchar(c_ptr_ptr_getptr(meta, i), 100))
        end do
   
        ! Discover the rows and columns of the raster image
        nrows = GDALGetRasterYSize(ds) 
        ncols = GDALGetRasterXSize(ds) 
    
        ! Allocate band array
        allocate(array(ncols,nrows))

        ! Get the c pointer to the array
        a_ptr = c_loc(array)

        ! Discover the number of bands
        nbands =  GDALGetRasterCount(ds)
    
        ! Iterate on all bands
        do band=1, nbands
            ! load iteratively the band handle of the input dataset ds
            bandH = GDALGetRasterBand(ds, band)

            ! load iteratively the band hadle of the output dataset dsOut
            OutBandH = GDALGetRasterBand(dsOut, band)

            ! Load pixels into 1D array
            err = GDALRasterIO(bandH,GF_Read,offcol,offrow,ncols,nrows,a_ptr,SIZE(array,1),SIZE(array,2),GDT_Float64,0,0)

            ! Do for columns and rows
            do i=1,ncols
                !$omp parallel do
                do j=1,nrows
                   inputpixelvalue = array(i,j)
                   call gsixs(inputpixelvalue,
     s                        inputgeometrycode,
     s                           solarzenithangledeg, solarazimuthangledeg,
     s                           satellitezenithangledeg, satelliteazimuthangledeg,
     s                           monthnumber, dayofthemonth,
     s                           dechourutchhddd, numberofcolumns, numberofrows,
     s                           equatorcrossingascendantlongitude,
     s                           equatorcrossingascendantdechour,
     s                           centralpixellongitude, centralpixellatitude,
     s                        inputatmosphereidcode,
     s                           filenameradiosonde34,
     s                           watercontent, ozonecontent,
     s                        inputaerosolidcode,
     s                           filenameaerosolvol,
     s                        outputpixelreflectance)
                   array(i,j) = outputpixelreflectance 
                end do
                !$omp end parallel do
            end do

            ! Write output array to the band handle in the output file
            err = GDALRasterIO(OutBandH,GF_Write,offcol,offrow,ncols,nrows,a_ptr,SIZE(array,1),SIZE(array,2),GDT_Float64,0,0)
        end do
    
        ! Deallocate
        deallocate(array)

        ! Write output to new raster on disk
        call GDALClose(ds)
        call GDALClose(dsOut)

      end program g6s

