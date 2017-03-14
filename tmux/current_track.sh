#!/bin/bash

NOW_PLAYING=$(osascript <<EOF
  if application "Spotify" is running then
      tell application "Spotify"
        set theName to name of the current
        set theArtist to artist of the current
        try
          return theName & " - " & theArtist
        on error err
        end try
      end tell
  else if application "iTunes" is running then
      tell application "iTunes"
        set theName to name of the current track
        set theArtist to artist of the current track
        try
            return theName & " - " & theArtist
        on error err
        end try
      end tell
  end if
EOF)
echo $NOW_PLAYING
