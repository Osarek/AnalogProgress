#!/bin/bash
for dir in ../*/source; do
  if [ -d "$dir" ] ; then
	  echo "$dir"
    cp -r source/common "$dir"
  fi
done



for dir in ../*/resources/drawables/images; do
  if [ -d "$dir" ] ; then
          echo "$dir"
    cp -r resources/drawables/images/sidetext "$dir"
  fi
done
