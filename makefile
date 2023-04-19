##########################################
# SET CORRECTLY THESE 6 PATHS TO COMPILE #
##########################################
BOOST_INC=/home/abiddan1/bin/miniconda3/include/boost
BOOST_LIB=/home/abiddan1/bin/miniconda3/lib
RMATH_INC=/home/abiddan1/bin/miniconda3/include
RMATH_LIB=/home/abiddan1/bin/miniconda3/lib
HTSLD_INC=/home/abiddan1/bin/miniconda3/include
HTSLD_LIB=/home/abiddan1/bin/miniconda3/lib

#COMPILER MODE C++11
CXX=g++ -std=c++0x

#COMPILER FLAGS
CXXFLAG_REL=-O3
CXXFLAG_DBG=-g
CXXFLAG_WRN=-Wall -Wextra -Wno-sign-compare -Wno-unused-local-typedefs -Wno-deprecated -Wno-unused-parameter

#BASE LIBRARIES
LIB_FLAGS=-L/home/abiddan1/bin/miniconda3/lib -ldl -ldeflate -lz -lbz2 -lm -lpthread -llzma -lhts -lboost_iostreams -lboost_program_options

#FILE LISTS
BFILE=bin/makeScaffold
HFILE=$(shell find src -name *.h)
TFILE=$(shell find lib -name *.h)
CFILE=$(shell find src -name *.cpp)
OFILE=$(shell for file in `find src -name *.cpp`; do echo obj/$$(basename $$file .cpp).o; done)
VPATH=$(shell for file in `find src -name *.cpp`; do echo $$(dirname $$file); done)

#DEFAULT VERSION (I.E. UNIGE DESKTOP RELEASE VERSION)
all: exec 

#UNIGE DESKTOP RELEASE VERSION
exec: CXXFLAG=$(CXXFLAG_REL) $(CXXFLAG_WRN)
exec: IFLAG=-Ilib/OTools -Ilib -I$(RMATH_INC) -I$(HTSLD_INC) -I$(BOOST_INC)
exec: LIB_FILES=$(RMATH_LIB)/libRmath.a 
exec: LDFLAG=$(CXXFLAG_REL)
exec: $(BFILE)

#COMPILATION RULES
$(BFILE): $(OFILE)
	$(CXX) $^ $(LIB_FILES) -o $@ $(LIB_FLAGS) $(LDFLAG)

obj/makeScaffold.o: src/makeScaffold.cpp $(HFILE) $(TFILE)
	$(CXX) -o $@ -c $< $(CXXFLAG) $(IFLAG)

obj/data_mendel.o: src/data_mendel.cpp src/data.h $(TFILE)
	$(CXX) -o $@ -c $< $(CXXFLAG) $(IFLAG)

obj/data_write.o: src/data_write.cpp src/data.h $(TFILE)
	$(CXX) -o $@ -c $< $(CXXFLAG) $(IFLAG)

obj/data_read.o: src/data_read.cpp src/data.h $(TFILE)
	$(CXX) -o $@ -c $< $(CXXFLAG) $(IFLAG)

obj/data_base.o: src/data_base.cpp src/data.h $(TFILE)
	$(CXX) -o $@ -c $< $(CXXFLAG) $(IFLAG)

clean: 
	rm -f obj/*.o $(BFILE)
