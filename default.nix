with import <nixpkgs> {}; {


build-cjdns = let version = "19"; in 
  stdenv.mkDerivation {

  name = "cjdns-${version}";

  src = ./.;

  buildInputs = [ which python27 nodejs libsodium emacs valgrind /*valkyrie*/ splint gdb rr 
    lcov pkgconfig gcc cppcheck ] ++
    # for flock
    stdenv.lib.optional stdenv.isLinux utillinux;

  buildPhase =
    stdenv.lib.optionalString stdenv.isArm "Seccomp_NO=1 "
    + ''CFLAGS="-I ${lib.getDev libsodium}/include/sodium" bash do'';
 
  meta = with stdenv.lib; {
    homepage = https://github.com/cjdelisle/cjdns;
    description = "Encrypted networking for regular people";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ehmry ];
    platforms = platforms.unix;
  };
};
}
