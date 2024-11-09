{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in with pkgs; rec {
        devShell = mkShell rec {
          buildInputs = [
            cargo
	    rustc

            libxkbcommon
            libGL

            # WINIT_UNIX_BACKEND=wayland
            wayland
	    vulkan-tools
	    vulkan-headers
	    vulkan-loader

                      ];
          LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
        };
      });
}

