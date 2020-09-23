with import <nixpkgs> {};

let

  pname = "criptext";
  version = "0.30.2";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://cdn.criptext.com/Criptext-Email-Desktop/linux/Criptext-latest.AppImage";
    sha256 = "0zndg7s4rydxf9p3ngwy9c077cizwbdiqm9jqa89xl48y92wqbz6";
  };

  appimageContents = appimageTools.extractType2 { inherit name src; };
in  appimageTools.wrapType2 {
  inherit name src;

  extraPkgs = pkgs: with pkgs; [
    libsecret
  ];
  
  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    install -m 444 -D \
      ${appimageContents}/${pname}.desktop \
      $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = with stdenv.lib; {
    description = "Molotov, TV and on-demand provider";
    homepage = "https://www.molotov.tv";
    license = licenses.unfree;
    maintainers = with maintainers; [ apeyroux ];
    platforms = [ "x86_64-linux" ];
  };

}
