{ config, pkgs, lib }:

lib.makeScope pkgs.newScope (self: with self; {
  iso-flags-png-320x420 = pkgs.iso-flags.overrideAttrs (p: p // {
    buildPhase = "make png-country-320x240-fancy";
    # installPhase = "mkdir -p $out/share && mv build/png-country-4x2-fancy/res-320x240 $out/share/iso-flags-png-320x420";
    installPhase = "mkdir -p $out/share && mv build/png-country-4x2-fancy/res-320x240 $out/share/iso-flags-png";
  });

  iso-flags-svg = pkgs.iso-flags.overrideAttrs (p: p // {
    buildPhase = "mkdir -p $out/share";
    installPhase = "mv svg $out/share/iso-flags-svg";
  });

  # Extensions added here will be shipped by default
  # We keep this in sync with a default Mint installation
  # Right now (only) nemo-share is missing
  nemoExtensions = [
    folder-color-switcher
    nemo-emblems
    nemo-fileroller
    nemo-python
  ];

  cinnamon-common = callPackage ./cinnamon-common { };
  cinnamon-control-center = callPackage ./cinnamon-control-center { };
  cinnamon-desktop = callPackage ./cinnamon-desktop { };
  cinnamon-gsettings-overrides = callPackage ./cinnamon-gsettings-overrides { };
  cinnamon-menus = callPackage ./cinnamon-menus { };
  cinnamon-translations = callPackage ./cinnamon-translations { };
  cinnamon-screensaver = callPackage ./cinnamon-screensaver { };
  cinnamon-session = callPackage ./cinnamon-session { };
  cinnamon-settings-daemon = callPackage ./cinnamon-settings-daemon { };
  cjs = callPackage ./cjs { };
  folder-color-switcher = callPackage ./folder-color-switcher { };
  nemo = callPackage ./nemo { };
  nemo-emblems = callPackage ./nemo-extensions/nemo-emblems { };
  nemo-fileroller = callPackage ./nemo-extensions/nemo-fileroller { };
  nemo-python = callPackage ./nemo-extensions/nemo-python { };
  nemo-with-extensions = callPackage ./nemo/wrapper.nix { };
  mint-artwork = callPackage ./mint-artwork { };
  mint-cursor-themes = callPackage ./mint-cursor-themes { };
  mint-l-icons = callPackage ./mint-l-icons { };
  mint-l-theme = callPackage ./mint-l-theme { };
  mint-themes = callPackage ./mint-themes { };
  mint-x-icons = callPackage ./mint-x-icons { };
  mint-y-icons = callPackage ./mint-y-icons { };
  muffin = callPackage ./muffin { };
  xapp = callPackage ./xapp { };
  xreader = callPackage ./xreader { };
  xviewer = callPackage ./xviewer { };
}) // lib.optionalAttrs config.allowAliases {
  # Aliases need to be outside the scope or they will shadow the attributes from parent scope.
  bulky = lib.warn "cinnamon.bulky was moved to top-level. Please use pkgs.bulky directly." pkgs.bulky; # Added on 2024-07-14
  pix = lib.warn "cinnamon.pix was moved to top-level. Please use pkgs.pix directly." pkgs.pix; # Added on 2024-07-14
  warpinator = lib.warn "cinnamon.warpinator was moved to top-level. Please use pkgs.warpinator directly." pkgs.warpinator; # Added on 2024-07-14
  xapps = pkgs.cinnamon.xapp; # added 2022-07-27
}
