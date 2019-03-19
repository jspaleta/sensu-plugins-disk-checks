#!/bin/bash


if [ -d dist ]; then
  files=( dist/*.tar.gz )
  file=$(basename "${files[0]}")
  IFS=_ read -r package leftover <<< "$file"
  unset leftover
  if [ -n "$package" ]; then
    echo "Generating sha512sum for ${package}"
    cd dist || exit
    sha512_file="${package}_sha512-checksums.txt"
    echo "${sha512_file}" > sha512_file
    echo "sha512_file: $(cat sha512_file)"
    sha512sum ./*.tar.gz > "${sha512_file}"
    echo ""
    cat "${sha512_file}"
  fi
else
  echo "error dist directory is missing"
fi

