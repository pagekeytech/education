{ pkgs ? import <nixpkgs> { }, src ? ./src, subdir ? "" }:

let theSource = src; in
pkgs.stdenv.mkDerivation rec {
  pname = "sample-app-cpp";
  version = "1.0.0";

  src = "${theSource}/${subdir}";

  nativeBuildInputs = with pkgs; [ gcc ];

  meta = with pkgs.lib; {
    description = "A simple Hello World C++ app";
    license = licenses.mit;
  };

  buildPhase = ''
    mkdir -p $out/bin
    g++ $src/main.cpp -o sample-app-cpp
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv sample-app-cpp $out/bin/
  '';
}
