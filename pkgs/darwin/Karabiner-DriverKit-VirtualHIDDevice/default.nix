{ Karabiner-DriverKit-VirtualHIDDevice-src, pkgs, cpio, stdenv, xar }:

stdenv.mkDerivation {
  pname = "Karabiner-DriverKit-VirtualHIDDevice";
  version = "1.15.0";
  # use /raw/main/dist/* from filetree
  src = pkgs.fetchurl {
    # full path: "https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/raw/main/dist/Karabiner-DriverKit-VirtualHIDDevice-1.15.0.pkg";
    url =
      "${Karabiner-DriverKit-VirtualHIDDevice-src}/dist/Karabiner-DriverKit-VirtualHIDDevice-1.15.0.pkg";
    sha256 = "sha256-Dkrnsc8waLs6le9k5aVSMKhL9KXm8FV47lnG/vZo4zE=";

  };

  buildInputs = [ cpio xar ];
  unpackPhase = ''
    xar -xf $src
    mv Payload Payload.gz
    gzip -d Payload.gz
    mkdir extracted && cd extracted && cpio -i < ../Payload
  '';
  dontBuild = true;
  installPhase = ''
    cp -r . $out
  '';
}