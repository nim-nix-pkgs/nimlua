{
  description = ''glue code generator to bind Nim and Lua together using Nim's powerful macro'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimLUA-v0_3_8.flake = false;
  inputs.src-nimLUA-v0_3_8.ref   = "refs/tags/v0.3.8";
  inputs.src-nimLUA-v0_3_8.owner = "jangko";
  inputs.src-nimLUA-v0_3_8.repo  = "nimLUA";
  inputs.src-nimLUA-v0_3_8.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimLUA-v0_3_8"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimLUA-v0_3_8";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}