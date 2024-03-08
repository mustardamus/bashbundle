file="";files=""
while read line; do
  if [[ "$line" == "#EMBED "* ]]; then
    file=${line/\#EMBED /};files="$file $files";continue
  fi
  [[ ! -n "$file" ]] && continue
  if [[ "$line" != "#END"* ]]; then
    echo "${line/\#/}" >> "$file"
  else
    file=""
  fi
done < $0
if [[ -f "setup.sh" ]]; then
  bash setup.sh && rm `echo "$files" | xargs`
fi
