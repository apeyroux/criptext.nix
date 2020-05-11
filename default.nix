with import <nixpkgs> {};

let

  version = "0.28.5";

  criptext-app = fetchurl {
    url = "https://cdn.criptext.com/Criptext-Email-Desktop/linux/Criptext-latest.AppImage";
    sha256 = "1ywjbnksdv8hi71bz7x3q1mpi3vxyfqqpwz451y9qy48mwwfizha";
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
