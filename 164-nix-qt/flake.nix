{
  description = "A simple C++ Hello World flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    pkgs.stdenv.mkDerivation {
      name = "hello";
      src = self;
      buildInputs = [ pkgs.cmake pkgs.qt6.qtbase ];
      dontWrapQtApps = true;
      preFixup = ''
        echo hello world
      '';
      buildPhase = ''
        echo Here we are $(pwd)
        echo HEre is $(ls)
        mkdir build
        cd build
        # cmake ..
        # make
        # mv NixQt $out/bin/NixQt
      '';
    };
    # Define the development shell
    devShell.x86_64-linux = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    pkgs.mkShell {
      buildInputs = [
        pkgs.cmake
        pkgs.gcc
        pkgs.qt6.qtbase
        pkgs.qt6.qtdeclarative
        pkgs.qtcreator  # Include Qt Creator only in the dev shell
      ];
    };
  };
}



# {
#   outputs =
#     { nixpkgs, self }: # Note the use of `self` which allows reusing flake's outputs in itself
#     let
#       pkgs = import nixpkgs { system = "x86_64-linux"; };
#     in
#     {
#       packages.x86_64-linux.default = pkgs.hello;
#       devShells.x86_64-linux.default = pkgs.mkShell {
#         packages = [ self.packages.x86_64-linux.default ];
#       };
#     };
# }
