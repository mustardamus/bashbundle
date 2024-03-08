#!/usr/bin/env bash

src_path="$1"
dest_path="$2"
attrib="# Created with BashBundle v0.1 - https://github.com/mustardamus/bashbundle"
head='cat <<"BASHBUNDLE" > _bb.sh && bash _bb.sh && rm _bb.sh'
foot="BASHBUNDLE"
extractor=$(<extractor.sh)

echo "$attrib" > $dest_path
echo "$head" >> $dest_path
echo "$extractor" >> $dest_path
echo "" >> $dest_path

for file_path in $src_path/*; do
  if [[ -f "$file_path" ]]; then
    file_name=${file_path/$src_path\//}
    file_content=$(<$file_path)

    echo "-> $file_path"
    echo "#EMBED $file_name" >> $dest_path
    echo "$file_content" | sed 's/^/#/' >> $dest_path
    echo "#END" >> $dest_path
    echo "" >> $dest_path
  fi
done

echo "$foot" >> $dest_path
