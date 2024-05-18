FC = gfortran
FFLAGS = -m64 -O3 -I/usr/local/include -ffixed-line-length-132
TARGET_ARCH =
LDFLAGS = -m64 -L/usr/local/lib
BLIBS = -lfortrangis -lfortranc -lgdal -fopenmp

EXE = g6s
INSTALL_DIR = /usr/local/bin

.SUFFIXES:

.SUFFIXES:.o.f.plt

SRC = $(wildcard src/*.f)
OBJ = $(patsubst src/%.f,%.o,$(SRC))

%.o : src/%.f
	$(FC) $(FFLAGS) -c $< -o $@

$(EXE): $(OBJ)
	$(FC) $(LDFLAGS) $(FFLAGS) $(OBJ) $(BLIBS) -o $(EXE)

clean:
	rm -f $(EXE) $(OBJ)

install: $(EXE)
	install -m 755 $(EXE) $(INSTALL_DIR)
	
