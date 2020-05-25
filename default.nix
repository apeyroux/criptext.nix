with import <nixpkgs> {};

let

  version = "0.29.0";

  criptext-app = fetchurl {
    url = "https://cdn.criptext.com/Criptext-Email-Desktop/linux/Criptext-latest.AppImage";
    sha256 = "sha256:1kc35bfq5qv73qnb7skybic8v3kviczr2i9yg3ypp59dk50cvzdc";
    executable = true;
  };

  apprun = appimage-run.override {
    extraPkgs = pkgs: [
      libsecret
      sqlite
      
      corefonts
      dejavu_fonts
    ];
  };
  
  criptext-bin = writeScriptBin "criptext" ''
    #!${pkgs.stdenv.shell}

    XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf ${apprun}/bin/appimage-run ${criptext-app}
  '';

in criptext-bin
