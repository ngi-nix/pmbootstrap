{
  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }:
    with nixpkgs.lib;
    let
      supportedSystems = [ "x86_64-linux" "i686-linux" "aarch64-linux" ];
      forAllSystems' = systems: fun: nixpkgs.lib.genAttrs systems fun;
      forAllSystems = forAllSystems' supportedSystems;
    in
    {
      overlays.pmbootstrap =
        final: prev:
        {
          pmbootstrap = final.python3Packages.callPackage ./pmbootstrap.nix {};
        };
      
      overlay = self.overlays.pmbootstrap;

      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs
            { inherit system;
              overlays = mapAttrsToList (_: id) self.overlays;
            };
        in
          {
            inherit (pkgs) pmbootstrap;
          }
      );

      defaultPackage = forAllSystems (system:
        self.packages.${system}.pmbootstrap
      );

      apps = self.packages;

      defaultApp = self.defaultPackage;

      devShell = forAllSystems (system:
        let
          pkgs = import nixpkgs
            { inherit system;
              overlays = mapAttrsToList (_: id) self.overlays;
            };
        in
          pkgs.mkShell {
            nativeBuildInputs = with pkgs;
              [ (python3.withPackages (pkgs: with pkgs;
                [ flake8 ]))

                openssl git sudo
              ];
          }
      );
    };
}
