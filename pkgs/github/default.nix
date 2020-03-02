{ stdenv, fetchzip, makeWrapper, appName ? "GitHub Desktop.app" }:
stdenv.mkDerivation rec {
  version = "1.6.1-2e2f9d3e";
  name = "github-desktop-${version}";
  sha256 = "0lldx0vbvr5i9ix9kjcczkbldfw8n2m9yza1p9aq13y12dblbzcr";
  buildInputs = [ makeWrapper ];
  src = fetchzip {
    url = "https://desktop.githubusercontent.com/releases/${version}/GitHubDesktop.zip";
    inherit sha256;
  };
  installPhase = ''
    mkdir -p  $out/bin
    mkdir -p "$out/Applications/${appName}"
    cp -R $src/Contents "$out/Applications/${appName}"

    CONTENTS="$out/Applications/${appName}/Contents"
    ELECTRON="$CONTENTS/MacOS/GitHub Desktop"
    CLI="$CONTENTS/Resources/app/cli.js"

    makeWrapper "$ELECTRON" $out/bin/github \
      --add-flags "\"$CLI\"" \
      --set ELECTRON_RUN_AS_NODE 1
  '';
}
