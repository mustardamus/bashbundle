mkdir -p tmp/in

cat <<"EOF" > tmp/in/message.txt
Free Assange!
EOF

cat <<"EOF" > tmp/in/url.txt
https://www.freeassange.net
EOF

bash bundler.sh tmp/in tmp/bundle.sh

cd tmp
bash bundle.sh

message=$(<message.txt)
url=$(<url.txt)

if [[ "$message" == "Free Assange!" ]] && [[ "$url" == "https://www.freeassange.net" ]]; then
  echo "-- Extraction works! --"
else
  echo "-- Extraction failed! --"
fi

cd ..
cat <<"EOF" > tmp/in/setup.sh
message=`cat message.txt`
url=$(<url.txt)
echo "$message - $url"
EOF

bash bundler.sh tmp/in tmp/bundle.sh
out=`bash tmp/bundle.sh`

if [[ "$out" == "Free Assange! - https://www.freeassange.net" ]]; then
  echo "-- Setup works! --"
else
  echo "-- Setup failed! --"
fi

rm -rf tmp
