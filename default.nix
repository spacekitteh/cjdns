with import <nixpkgs> {}; {


build-cjdns = let version = "19"; in 
  stdenv.mkDerivation {

  name = "cjdns-${version}";

  src = ./.;

  buildInputs = [ which python27 nodejs libsodium ] ++
    # for flock
    stdenv.lib.optional stdenv.isLinux utillinux;

  buildPhase =
    stdenv.lib.optionalString stdenv.isArm "Seccomp_NO=1 "
    + "bash do -I ${libsodium}/include/";
 
  meta = with stdenv.lib; {
    homepage = https://github.com/cjdelisle/cjdns;
    description = "Encrypted networking for regular people";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ehmry ];
    platforms = platforms.unix;
  };
};
}
