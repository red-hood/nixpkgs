{ lib, stdenv
, fetchurl
, pkg-config
, autoconf
, gtk2
, alsa-lib
, SDL
, jack2
, audiofile
, goocanvas # graphical envelope editing
}:

stdenv.mkDerivation rec {
  pname = "soundtracker";
  version = "1.0.2.1";

  src = fetchurl {
    # Past releases get moved to the "old releases" directory.
    # Only the latest release is at the top level.
    # Nonetheless, only the name of the file seems to affect which file is
    # downloaded, so this path should be fine both for old and current releases.
    url = "mirror://sourceforge/soundtracker/soundtracker-${version}.tar.xz";
    sha256 = "0nh0dwz8nldc040q6n06vlazhss8ms42r2dffhjcrqj3hbrvfx82";
  };

  nativeBuildInputs = [
    pkg-config
    autoconf
  ];
  buildInputs = [
    gtk2
    SDL
    jack2
    audiofile
    goocanvas
  ] ++ lib.optional stdenv.isLinux alsa-lib;

  meta = with lib; {
    description = "A music tracking tool similar in design to the DOS program FastTracker and the Amiga legend ProTracker";
    longDescription = ''
      SoundTracker is a pattern-oriented music editor (similar to the DOS
      program 'FastTracker'). Samples are lined up on tracks and patterns
      which are then arranged to a song. Supported module formats are XM and
      MOD; the player code is the one from OpenCP. A basic sample recorder
      and editor is also included.
    '';
    homepage = "http://www.soundtracker.org/";
    downloadPage = "https://sourceforge.net/projects/soundtracker/files/";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ fgaz ];
    platforms = platforms.all;
    # gdk/gdkx.h not found
    broken = stdenv.isDarwin;
  };
}
