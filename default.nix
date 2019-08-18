with import <nixpkgs> {};

let

  version = "4.1.0";

  molotov-app = fetchurl {
    url = "http://desktop-auto-upgrade.molotov.tv/linux/${version}/molotov.AppImage";
    sha256 = "14kh7ch6r3gk7j5ylk3hch1db87f69rli23rnh6kzx89nvpjs5vl";
    executable = true;
  };

  molotov-bin = writeScriptBin "molotov" ''
    #!${pkgs.stdenv.shell}
    ${appimage-run}/bin/appimage-run ${molotov-app}
  '';

in molotov-bin
