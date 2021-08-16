{ lib

, fetchPypi, buildPythonApplication, buildPythonPackage
, pytest, pytest-cov, flake8
, openssl, git, sudo
}:
with lib;
let
  pname = "pmbootstrap";
  version = "1.35.0";

  pmb = buildPythonPackage {
    pname = "pmb";
    version = "0.0.10";

    src = fetchPypi {
      pname = "pmb";
      version = "0.0.10";
      sha256 = "sha256-C5AJSWu4nUVtbq6Hpw0KlyhafMotXh/kYG4QPbg9330=";
    };
  };
in
buildPythonApplication {
  inherit pname version;

  doCheck = false; # the tests need something called pmb and pmb_test, i found the formet but not the latter
  
  buildInputs =
    [ # pytest
      # pytest-cov
      # pmb
      flake8
    ];

  preFixup = ''
    makeWrapperArgs+=( "--prefix" "PATH" ":" "${makeBinPath [ openssl git sudo ]}" ) 
  ''; 

  src = fetchPypi {
    inherit version pname;
    sha256 = "sha256-fp9L1cncMivqfuJXyw+AGz2LkTS4tSEB680I77aR1i0=";
  };
}
