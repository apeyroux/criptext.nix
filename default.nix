with import <nixpkgs> {};

let

  version = "0.27.1";

  criptext-app = fetchurl {
    url = "https://cdn.criptext.com/Criptext-Email-Desktop/linux/Criptext-latest.AppImage";
    sha256 = "118l907wd6xf88m6d599a1draw4bgm2mxx4d6c35apgiyzyq23dy";
    executable = true;
  };

  apprun = appimage-run.override {
    extraPkgs = pkgs: [libsecret];
  };
  
  criptext-bin = writeScriptBin "criptext" ''
    #!${pkgs.stdenv.shell}

    XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS ${apprun}/bin/appimage-run ${criptext-app}
  '';

in criptext-bin
