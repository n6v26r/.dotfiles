#!/bin/bash

title=$(MediaControl --title)
artist=$(MediaControl --artist)

notitle="Play Something"
noartist="No Artist"

[ "$title" != "$notitle" ] && [ "$title" != "$notitle" ] && echo $title
