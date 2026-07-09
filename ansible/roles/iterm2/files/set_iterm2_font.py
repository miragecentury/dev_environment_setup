#!/usr/bin/env python3
"""Patch iTerm2 profile fonts without replacing the full preferences plist."""

import os
import plistlib
import sys

font = os.environ["ITERM2_FONT"]
plist_path = os.environ["ITERM2_PLIST"]

if not os.path.isfile(plist_path):
    print("skip")
    sys.exit(0)

with open(plist_path, "rb") as handle:
    data = plistlib.load(handle)

changed = False
for profile in data.get("New Bookmarks", []):
    if profile.get("Normal Font") != font:
        profile["Normal Font"] = font
        changed = True
    if profile.get("Use Non-ASCII Font") is not False:
        profile["Use Non-ASCII Font"] = False
        changed = True

if changed:
    with open(plist_path, "wb") as handle:
        plistlib.dump(data, handle)
    print("changed")
else:
    print("ok")
