{
  lib,
  stdenv,
  fetchFromGitHub,
  fontc,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "google-sans-flex";
  version = "4.007";

  src = fetchFromGitHub {
    owner = "googlefonts";
    repo = "googlesans-flex";
    tag = "v${finalAttrs.version}";
    hash = "sha256-n3Ld16Qv9nN8tXl63FjXhNwb9aULQWEVkBgDDg057wg=";
  };

  nativeBuildInputs = [
    fontc
  ];

  buildPhase = ''
    runHook preBuild

    mkdir -p fonts/variable
    fontc sources/GoogleSansFlex.glyphspackage --flatten-components --decompose-transformed-components --output-file "fonts/variable/GoogleSansFlex[opsz,slnt,wdth,wght].ttf"

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/google-sans-flex
    cp fonts/variable/* $out/share/fonts/google-sans-flex

    runHook postInstall
  '';

  meta = {
    description = "Google Sans Flex variable font";
    homepage = "https://github.com/googlefonts/googlesans-flex";
    license = lib.licenses.ofl;
    maintainers = with lib.maintainers; [ heizu ];
    platforms = lib.platforms.all;
  };
})
