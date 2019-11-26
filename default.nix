with import <nixpkgs> {};

let

  version = "0.26.1";

  criptext-app = fetchurl {
    url = "https://cdn.criptext.com/Criptext-Email-Desktop/linux/Criptext-latest.AppImage";
    sha256 = "0p7zqjw4ra7h0jfsra2vcv3vn9jny77i81y90dvwvavs22w6hi1l";
    executable = true;
  };

  criptext-bin = writeScriptBin "criptext" ''
    #!${pkgs.stdenv.shell}

    XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS ${appimage-run}/bin/appimage-run ${criptext-app}
  '';

in criptext-bin
