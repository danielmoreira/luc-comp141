#!/bin/bash

# 'Usage: ./script/.ta.sh <groundtruth_csv_filepth> <student_csv_filepath>'
echo "Usage: .ta.sh <GT_CSV> <STUDENT_CSV>"
echo " Call: .ta.sh $1 $2"

# parameters (set it up according to semester challenge)
LINE_COUNT_35=14 # header's number of lines
LINE_COUNT_361=$((10386-LINE_COUNT_35)) # file 1's number of lines
LINE_COUNT_362=$((39483-LINE_COUNT_35-LINE_COUNT_361)) # file's 2 number of lines

# holds the computed grade
GRADE=0.0


# task 3.5
head -n $LINE_COUNT_35 "$1" > ./gt_3.5.txt
head -n $LINE_COUNT_35 "$2" > ./st_3.5.txt
sdiff -s ./gt_3.5.txt ./st_3.5.txt > ./cp_3.5.txt
PT35="$(wc -l < ./cp_3.5.txt)"

DEN_35=$(bc <<< "$LINE_COUNT_35 * 1.0")
RED_35=$(bc <<< "scale=2; $PT35 / $DEN_35")
GRADE_35=$(bc <<< "2.0 * (1.0 - $RED_35)")
GRADE=$(bc <<< "$GRADE + $GRADE_35")

echo "---------------------------"
if [ "$PT35" -eq 0 ]; then
  echo "  3.5: correct (+$GRADE_35 pt)"
else
  echo "  3.5: incorrect, $PT35 different line(s), (+$GRADE_35 pt)"
fi

rm -f ./gt_3.5.txt ./st_3.5.txt ./cp_3.5.txt


# task 3.6.1
head -n $((LINE_COUNT_35 + LINE_COUNT_361)) "$1" | tail -n  $LINE_COUNT_361 > ./gt_3.6.1.txt
cp "$2" ./st_3.6.1.txt

sed -i '' "s/\$HOME/#HOME/g" ./gt_3.6.1.txt
sed -i '' "s/\$HOME/#HOME/g" ./st_3.6.1.txt

PIPE_PROB=0
PIPE_PROB_MSG="all \"|\" replaced (ok)"
PIPE=$(grep "|" ./st_3.6.1.txt)
if [ -n "$PIPE" ]; then
  PIPE_PROB=1
  PIPE_PROB_MSG="there are still \"|\" chars"
  sed -i '' "s/|/,/g" ./st_3.6.1.txt
fi

HOME_PROB=0
HOMEP=$(grep "/home/comp141" ./st_3.6.1.txt)
if [ -n "$HOMEP" ]; then
  HOME_PROB=1
  sed -i '' "s/\/home\/comp141/#HOME/g" ./st_3.6.1.txt
fi

sed '1!G;h;$!d' ./gt_3.6.1.txt > ./tg_3.6.1.txt

LINE_1_361=0
while IFS= read -r line; do
  LINE_1_361=$(grep -n "$line" ./st_3.6.1.txt | cut -d: -f1)
  if [ -n "$LINE_1_361" ]; then
    break
  fi
done < ./gt_3.6.1.txt

LINE_2_361=0
while IFS= read -r line; do
  LINE_2_361=$(grep -n "$line" ./st_3.6.1.txt | cut -d: -f1)
  if [ -n "$LINE_2_361" ]; then
    break
  fi
done < ./tg_3.6.1.txt

LINE_COUNT_361_ST=0
if (( LINE_2_361 > LINE_1_361 )); then
  LINE_COUNT_361_ST=$((LINE_2_361 - LINE_1_361 + 1))
fi

NUM_361=$((LINE_COUNT_361 > LINE_COUNT_361_ST ? LINE_COUNT_361 - LINE_COUNT_361_ST : LINE_COUNT_361_ST - LINE_COUNT_361))

DEN_361=0.0
if ((LINE_COUNT_361 > LINE_COUNT_361_ST)); then
  DEN_361=$LINE_COUNT_361
else
  DEN_361=$LINE_COUNT_361_ST
fi

FIX_361=$(bc <<< "scale=2; $NUM_361 / $DEN_361")
if (( $(echo "$FIX_361 == 0.0" | bc -l) && $(echo "$NUM_361 > 0.0" | bc -l) )); then
  FIX_361=0.1
fi

GRADE_361=$(bc <<< "1.0 - $FIX_361")

if [ $PIPE_PROB -eq 0 ]; then
  GRADE_361=$(bc <<< "$GRADE_361 + 1.0")
fi
GRADE=$(bc <<< "$GRADE + $GRADE_361")

if (( $(echo "$GRADE_361 == 2.0" | bc -l) )); then
  echo "3.6.1: correct (+$GRADE_361 pt)"
else
  echo "3.6.1: incorrect, $PIPE_PROB_MSG, ~$NUM_361 different line(s) (+$GRADE_361 pt)"
fi

rm -f ./gt_3.6.1.txt ./tg_3.6.1.txt ./st_3.6.1.txt ./cp_3.6.1.txt


# task 3.6.2
tail -n $LINE_COUNT_362 "$1" > ./gt_3.6.2.txt
cp "$2" ./st_3.6.2.txt

sed -i '' "s/\$HOME/#HOME/g" ./gt_3.6.2.txt
sed -i '' "s/\$HOME/#HOME/g" ./st_3.6.2.txt

HOMEP=$(grep "/home/comp141" ./st_3.6.2.txt)
if [ -n "$HOMEP" ]; then
  HOME_PROB=1
  sed -i '' "s/\/home\/comp141/#HOME/g" ./st_3.6.2.txt
fi

sed '1!G;h;$!d' ./gt_3.6.2.txt > ./tg_3.6.2.txt

LINE_1_362=0
while IFS= read -r line; do
  LINE_1_362=$(grep -n "$line" ./st_3.6.2.txt | cut -d: -f1)
  if [ -n "$LINE_1_362" ]; then
    break
  fi
done < ./gt_3.6.2.txt

LINE_2_362=0
while IFS= read -r line; do
  LINE_2_362=$(grep -n "$line" ./st_3.6.2.txt | cut -d: -f1)
  if [ -n "$LINE_2_362" ]; then
    break
  fi
done < ./tg_3.6.2.txt

LINE_COUNT_362_ST=0
if (( LINE_2_362 > LINE_1_362 )); then
  LINE_COUNT_362_ST=$((LINE_2_362 - LINE_1_362 + 1))
fi

NUM_362=$((LINE_COUNT_362 > LINE_COUNT_362_ST ? LINE_COUNT_362 - LINE_COUNT_362_ST : LINE_COUNT_362_ST - LINE_COUNT_362))

DEN_362=0.0
if ((LINE_COUNT_362 > LINE_COUNT_362_ST)); then
  DEN_362=$LINE_COUNT_362
else
  DEN_362=$LINE_COUNT_362_ST
fi

FIX_362=$(bc <<< "scale=2; $NUM_362 / $DEN_362")
if (( $(echo "$FIX_362 == 0.0" | bc -l) && $(echo "$NUM_362 > 0.0" | bc -l) )); then
  FIX_362=0.1
fi

GRADE_362=$(bc <<< "2.0 * (1.0 - $FIX_362)")
GRADE=$(bc <<< "$GRADE + $GRADE_362")

if (( $(echo "$GRADE_362 == 2.0" | bc -l) )); then
  echo "3.6.2: correct (+$GRADE_362 pt)"
else
  echo "3.6.2: incorrect, ~$NUM_362 different line(s) (+$GRADE_362 pt)"
fi

rm -f ./gt_3.6.2.txt ./tg_3.6.2.txt ./st_3.6.2.txt ./cp_3.6.2.txt


# task 3.7
GRADE_37=0.0
if (( HOME_PROB == 0 )); then
  GRADE_37=2.0
  echo "  3.7: correct (+$GRADE_37 pt)"
else
  echo "  3.7: incorrect, there are still '/home/comp141' values (+$GRADE_37 pt)"
fi
GRADE=$(bc <<< "$GRADE + $GRADE_37")


# task 3.8
NONE_PROB=0
NONEP=$(grep "none" "$2")
if [ -n "$NONEP" ]; then
  NONE_PROB=1
fi

GRADE_38=0.0
if (( NONE_PROB == 0)); then
  GRADE_38=2.0
  echo "  3.8: correct (+$GRADE_38 pt)"
else
  echo "  3.8: incorrect, there are still 'none' values (+$GRADE_38 pt)"
fi
GRADE=$(bc <<< "$GRADE + $GRADE_38")


# TOTAL
echo "---------------------------"
echo "TOTAL: $GRADE pt"
