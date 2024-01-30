with import <nixpkgs>
{ };

mkShell {
  buildInputs = [
    nodePackages_latest.npm
    nodePackages_latest.webpack
    nodePackages_latest.webpack-cli
  ];

  shellHook =
    ''
      # export NODE_PATH="${nodePackages.webpack.out}/lib/node_modules";
      export NODE_PATH="${nodePackages_latest.webpack.out}/lib/node_modules";
    '';
}
