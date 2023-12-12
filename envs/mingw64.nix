with import <nixpkgs>
{
  crossSystem = {
    config = "x86_64-w64-mingw32";
  };
};

mkShell {
  buildInputs = [
    windows.mingw_w64_pthreads
    windows.pthreads
  ];

  shellHook =
    ''
      export LSP_CARGO_TARGET="x86_64-pc-windows-gnu"
      export CARGO_TARGET_X86_64_PC_WINDOWS_GNU_RUSTFLAGS="-L native=${windows.pthreads}/lib";
    '';
}
