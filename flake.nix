{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      nixpkgs,
      utils,
      ...
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        watch =
          let
            mupdf = "${pkgs.mupdf}/bin/mupdf";
            entr = "${pkgs.entr}/bin/entr";
            typst = "${pkgs.typst}/bin/typst";
          in
          pkgs.writeShellScriptBin "watch" ''
            trap 'kill $PS1 $PS2; exit' INT
            file="''${1:-main.typ}"
            output="$(dirname $file)/output.pdf"
            ${typst} w $file $output --root $PWD &
            PS1=$!
            ${mupdf} $output &
            PS2=$!
            echo $output | ${entr} pkill -HUP mupdf
          '';

        languages-toml =
          pkgs.writeText "languages.toml" # toml
            ''
              # Generated from flake.nix
              [language-server.tinymist]
              command = "${pkgs.tinymist}/bin/tinymist"
              config = { typstExtraArgs = ["main.typ"] }

              [[language]]
              name = "typst"
              auto-format = true
              language-servers = [ "tinymist", "ltex-ls-plus" ]
                        
            '';
      in
      {
        devShell = pkgs.mkShell {
          buildInputs =
            [
              watch
            ]
            ++ (with pkgs; [
              typst
              tinymist
            ]);

          shellHook = ''
            mkdir -p .helix
            rm -f .helix/languages.toml
            cp ${languages-toml} .helix/languages.toml
          '';
        };
      }
    );
}
