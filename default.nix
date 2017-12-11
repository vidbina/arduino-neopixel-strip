{ stdenv, pkgs }:

stdenv.mkDerivation rec {
  name = "arduino-neopixel-${version}";
  src = ./.;
  version = "0.1.0";

  ARDUINO_PATH="${pkgs.arduino-core}";

  buildInputs = with pkgs; [
    arduino
    avrdude
  ];

  shellHook = ''
    export PATH="$PATH:${pkgs.arduino-core}/share/arduino/"
  '';
}
