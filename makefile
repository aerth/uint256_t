CXXFLAGS += -I. -Iuint128_t

library: libuint256.a
libuint256.a: uint256_t.o uint128_t/uint128_t.o
	ar ruv $@ $^
	ranlib $@
libuint256.o: *.cpp uint128_t/*.cpp
	${CXX} -c ${CXXFLAGS} $^ ${LDFLAGS}
clean:
	${RM} -v *.a *.o *.so
	test ! -d uint128_t || ${RM} -v uint128_t/*.o 
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@


install: libuint256.a
	@install -v -t /usr/local/lib/ $^
	@mkdir -p /usr/local/include/uint256/
	@install -v -t /usr/local/include/uint256/ uint128_t/*.{h,include}
	@install -v -t /usr/local/include/uint256/ *.{h,include}

