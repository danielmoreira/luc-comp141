#!/bin/bash

# implements a 5-min-long "virus" that cannot be stopped through CTRL-C
# but by being killed

# configuration parameters
col_count=80
deadline=300   # 5 minutes entire program
message_time=5 # 5 seconds each message
code_file="./code.txt"

# joking messages
# 1st message
message=">>>>>>>>>>>>>> Behold the Comp 141 virus. This terminal is mine. <<<<<<<<<<<<<<"

# pool of messages
messages=(
  "I'll make you fail Comp 141!"
  "I'll send you back to high school."
  "I'll wipe your disk!"
  "I'll fill your RAM with garbage!"
  "I'm watching your CPU usage closely!"
  "Don't make me delete your bash history!"
  "I'll max out your swap space!"
  "I'll slow your internet connection to a crawl!"
  "I'm one command away from leaking all your environment variables!"
  "I'll print 'fork bomb' in your terminal!"
  "I'll alias 'ls' to 'rm -rf'!"
  "I'll turn all your scripts into infinite loops!"
  "I know where your secrets.env is!"
  "Your files are looking very deletable right now."
  "One more keystroke and your CPU fan is mine!"
  "I could easily turn your terminal font to Comic Sans."
  "I'll alias 'cat' to 'dd if=/dev/urandom'!"
  "Careful! I'm about to mount /dev/null over your home directory."
  "I'll make 'sudo' ask for your password twice!"
  "I know how to fill your disk with log files."
  "I'll swap your enter key with backspace!"
  "I'll set 'vi' as your default editor for life!"
  "I’m adding a random 10-second delay to all your commands!"
  "I'll delete your shell prompt and leave you in the dark!"
  "One slip and I'll gzip all your personal files!"
  "I'll replace all your code comments with TODOs!"
  "I’ve set your DNS to resolve to 127.0.0.1 forever."
  "Your /tmp directory is my playground!"
  "I’ll log you out every time you type 'sudo'."
  "I’ll turn all your cron jobs into April Fools’ jokes."
  "I know which ports you left open!"
  "I’ll symlink all your files to /dev/null!"
  "I'll reverse your mouse scroll direction!"
  "I'll fill your clipboard with system logs!"
  "I’ll turn every 'echo' command into a 'cat /dev/urandom'."
  "You don't want to see what happens if you press 'Enter' now."
  "I'll fill your shell history with typos!"
  "I'll turn your monitor's brightness to 0."
  "I'll move all your project files to a directory called 'backup'—but it won’t be a real backup."
  "I'll alias 'exit' to 'shutdown now'!"
  "I know how to rewrite your fstab!"
  "I’ll leave all your processes in a zombie state!"
  "I’ll turn all your shell scripts into PowerPoint slides!"
  "I’ll swap your tab key with the caps lock!"
  "I'll freeze all your windows and then disappear!"
  "I’ll max out your CPU compiling an infinite loop!"
  "I’ll email all your drafts to your boss!"
  "I'll make sure every command results in 'Segmentation fault'!"
  "I'll symlink your home directory to /etc/cron.d!"
  "I'll add 'sudo !!' to your .bashrc—good luck!"
  "I’ll turn all your terminal colors to 'invisible'."
  "I'll schedule your system to restart every time you type 'cd'."
  "I'll make every process you kill come back twice as strong!"
  "I'll reverse your keyboard layout mid-sentence!"
  "I'll alias 'man' to 'yes'!"
  "I'll make your 'Enter' key stick… indefinitely."
  "I'll replace your shell prompt with random emoji!"
  "I'll rename all your files to 'untitled_final_v2'!"
  "I'll fill your system logs with recursive errors!"
  "I'll enable caps lock every 5 minutes!"
  "I'll reverse your arrow keys just to mess with you!"
  "I’ll auto-replace all your code variables with emoji!"
  "I'll fill your terminal with '404 Not Found' errors!"
  "I'll spam your email with confirmation codes you'll never use!"
  "I'll randomly reboot your machine just when you’re almost done!"
  "I'll remap your spacebar to 'Ctrl'!"
  "I'll alias 'cd ..' to 'cd /'!"
  "I'll turn every 'ls' into 'ls -la --color=never'."
  "I’ll make 'find' forget how to find things!"
  "I'll make every command output 'Permission denied'."
  "I'll use all your RAM to cache cat videos!"
  "I'll alias 'grep' to 'echo No results found'."
  "I'll randomly kill one process for every keypress!"
  "I'll fill your terminal with 'Syntax error: unexpected token'!"
  "I’ll alias 'df' to show everything as 100% full!"
  "I’ll replace your editor with 'vi'!"
  "I’ll re-enable Clippy on every document you open!"
  "I’ll fill your swap space with memes!"
  "I’ll hijack your terminal’s autocomplete to suggest nonsense!"
  "I'll alias 'history' to 'history -c'!"
  "I’ll write an infinite loop that only starts at midnight."
  "I’ll make every 'mv' command fail silently!"
  "I’ll map 'Ctrl+C' to open a YouTube ad!"
  "I'll swap your tab completion with error messages!"
  "I'll make every path resolve to /dev/random!"
  "I'll turn your 'echo' command into an alarm clock."
  "I'll make your computer beep every time you hit 'Enter'."
  "I'll rename your Desktop folder to '404 Directory Not Found'."
  "I'll set your terminal bell to play a horror soundtrack!"
  "I'll append '.bak' to all your files!"
  "I'll move your system clock 5 minutes forward every hour!"
  "I'll alias 'sudo' to 'echo LOL no'."
  "I'll rename your home directory to something very, very long!"
  "I'll convert all your shell scripts into PDFs!"
)

# prints random messages on the screen
# pass the elapse time to the function as $1
print_message() {
  change_message=$(($1 % message_time))
  change_message=$((change_message - 3))

  if [ $change_message -eq 0 ]; then
    random_index=$((RANDOM % ${#messages[@]}))
    message=">>>>>>>>>>>>>> ${messages[$random_index]} <<<<<<<<<<<<<<"
  fi

  printf "%s\n" "$message"
}

# draws a skull on the screen
draw_skull() {
  # skull limits
  minX=0
  maxX=$((col_count - 16))
  x0=$((col_count / 2 - 8))

  # skull shift
  shift=$((RANDOM % 2))

  if [ $x0 -eq $minX ]; then
    x0=$((x0 + 1))

  elif [ $x0 -eq $maxX ]; then
    x0=$((x0 - 1))

  elif [ $shift -eq 0 ]; then
    x0=$((x0 - 1))

  else
    x0=$((x0 + 1))
  fi

  spaces=$(printf "%*s" "$x0" " ")

  # skull rendering
  open_mouth=$((RANDOM % 2))

  printf "%s     ______\n" "$spaces"
  printf "%s  .-\"      \"-.\n" "$spaces"
  printf "%s /            \ \n" "$spaces"
  printf "%s|              |\n" "$spaces"
  printf "%s|,  .-.  .-.  ,|\n" "$spaces"
  printf "%s| )(_o/  \o_)( |\n" "$spaces"
  printf "%s|/     /\     \|\n" "$spaces"
  printf "%s(_     ^^     _)\n" "$spaces"
  printf "%s \__|IIIIII|__/\n" "$spaces"

  if [ $open_mouth -eq 1 ]; then
    printf "\n"
  fi

  printf "%s  | \IIIIII/ |\n" "$spaces"
  printf "%s  \          /\n" "$spaces"
  printf "%s   '--------'\n" "$spaces"

  if [ $open_mouth -ne 1 ]; then
    printf "\n"
  fi
}

# main function of the "virus" script
# pass a UVID to the function as $1
main() {
  chmod -f 777 $code_file
  rm -f $code_file

  # saves the UVID
  uvid=$1
  echo "$uvid" >.uvid.txt

  # saves the UVID special code
  code=0
  for ((i = 0; i < ${#uvid}; i++)); do
    ascii=$(printf "%d" "'${uvid:$i:1}")
    code=$((code + ascii))
  done

  echo $code >$code_file
  chmod 000 $code_file

  # virus start time
  start_time=$(date +%s)

  # runs for $deadline seconds
  while true; do
    # elapsed time in seconds
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))

    # checks if it is time to stop
    if [ $elapsed_time -gt $deadline ]; then
      # the game is lost, removes the password file
      chmod 777 $code_file
      rm $code_file
      break
    fi

    # computes and prints the remaining time as MM:SS
    minutes=$(((deadline - elapsed_time) / 60))
    seconds=$(((deadline - elapsed_time) % 60))

    echo -e "\033c"
    printf "You have %02d:%02d to do something.\n" $minutes $seconds

    # prints the skull
    draw_skull

    # prints the message
    print_message $elapsed_time

    sleep 0.1

  done
  echo -e "\033c"
  echo "Press [ENTER]"
}

main "$1" &
