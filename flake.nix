{
  description =
    "Sophisticated chroot/build/flash tool to develop and install postmarketOS.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = flake-utils.lib.flattenTree rec {
          pmbootstrap = with pkgs.python3Packages;
            buildPythonApplication rec {
              pname = "pmbootstrap";
              version = "1.45.0";
              src = fetchPypi {
                inherit pname version;
                sha256 = "sha256-75ZFzhRsczkwhiUl1upKjSvmqN0RkXaM8cKr4zLgi4w=";
              };
              doCheck = false;
              meta = with pkgs.lib; {
                inherit description;
                homepage = "https://www.postmarketos.org/";
                license = licenses.gpl3Plus;
              };
            };
        };
        defaultPackage = packages.pmbootstrap;
        apps.pmbootstrap =
          flake-utils.lib.mkApp { drv = packages.pmbootstrap; };
        defaultApp = apps.pmbootstrap;
      });
}
