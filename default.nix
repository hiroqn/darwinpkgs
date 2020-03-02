{ nixpkgs ? <nixpkgs>, system ? builtins.currentSystem
, pkgs ? import nixpkgs { inherit system; }
}:
{
    desktop = pkgs.callPackage ./pkgs/github;
}
