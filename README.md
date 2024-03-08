# BashBundle

Bundle text files into a single `.sh` file and extract them by executing it.
Or use it as an installer by bundling a `setup.sh` with all the files it depends
on.

🔥 Works also by copy & pasting the bundled code directly into your terminal!

## Usage

```
bash bundle.sh [source directory] [destination file]
```

## Example 1: Bundle files; Extract files

Given we have these files:

`bundle-example/message.txt`

```
Free Assange!
```

`bundle-example/url.txt`

```
https://www.freeassange.net
```

To bundle them into a single `.sh` file:

```
bash bundler.sh bundle-example bundle-example.sh
```

To extract the files into the current directory:

```
bash bundle-example.sh
```

Or paste the code directly into your terminal (bash shell), it has the same
effect:

```bash
# Created with BashBundle v0.1 - https://github.com/mustardamus/bashbundle
cat <<"BASHBUNDLE" > _bb.sh && bash _bb.sh && rm _bb.sh
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

#EMBED message.txt
#Free Assange!
#END

#EMBED url.txt
#https://www.freeassange.net
#END
BASHBUNDLE
```

## Example 2: Bundle files; Extract files -> Run setup -> Delete files

If there is a `setup.sh` along the files, it will be executed after the files
are extracted, for example:

`setup-example/setup.sh`

```bash
message=`cat message.txt`
url=$(<url.txt)
echo "$message - $url"
```

`setup-example/message.txt`

```
Free Assange!
```

`setup-example/url.txt`

```
https://www.freeassange.net
```

Bundle them:

```
bash bundler.sh setup-example setup-example.sh
```

To extract the files, run `setup.sh` and delete all extracted files afterwards:

```
bash setup-example.sh
```

This will print:

```
Free Assange! - https://www.freeassange.net
```

Copy & paste directly into your terminal (bash shell), it will print the same
output. Try it:

```bash
# Created with BashBundle v0.1 - https://github.com/mustardamus/bashbundle
cat <<"BASHBUNDLE" > _bb.sh && bash _bb.sh && rm _bb.sh
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

#EMBED message.txt
#Free Assange!
#END

#EMBED setup.sh
#message=`cat message.txt`
#url=$(<url.txt)
#echo "$message - $url"
#END

#EMBED url.txt
#https://www.freeassange.net
#END
BASHBUNDLE
```

## But why?

I was looking for the simplest solution to kick off a server setup, you know,
update & install packages, install Ansible, run playbook, etc.

You could have a public Git repo somewhere with all the necessary files, then
`git clone` it and execute it, like `bash setup.sh`. This requires you to 1.
Create the repo, 2. Push the code, 3. Install `git` on server, 4. Clone the
repo, 5. Execute. Way too much work. And don't get me started if it's a
private repository. :P

You could also do the ye old `curl [url] | bash` method. If you are in control
of where the install script is hosted, it's maybe fine. If someone else hosts
the script you make yourself vulnerable, see
[Friends don’t let friends Curl | Bash](https://sysdig.com/blog/friends-dont-let-friends-curl-bash/).
Anyhow, let's say I host the script, I have to 1. Get it online somewhere (thats
at least 3 more steps), 2. Maybe install `curl` or `wget`, 3. Paste the
`curl|bash` command, 4. Execute. Better, but way more work than necessary :P

I could copy and paste the install script from my machine onto the server, and
run it. But what if there are multiple files? I'd still have to get them somehow
on the server. So, 1. Open a file on the server 2. Copy and paste the script
into it 3. Save it 4. Google how to :quit `vim`, 5. Get all necessary files on
the server, 6. Execute. Seemed like a good idea, but is a loooot of work :P

You guessed it, the best way is BashBundle! 1. I bundle all necessary files and
my `setup.sh` installer script, 2. I copy the complete bundled script, 3. I
paste it into the server terminal. 4. Win. If you know of a method that is less
work, please let me know :)

## Testing

```
bash test.sh
```

# [✊ Free Assange!](https://www.freeassange.net)
