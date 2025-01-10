#!/bin/bash

# 'Usage: .ta.sh <UVID>'
# Run on the SSH server side.
echo "Usage: ./.ta.sh <STUDENT_UVID>"
echo " Call: ./.ta.sh $1"

# holds the computed grade
GRADE=0.0
echo "---------------------------"

# 4.2
GRADE_42=0.0
FIND_42="$(find "/home/$1" -type f -name "data_gen.sh" 2>/dev/null)"
if [ -z "$FIND_42" ]; then
  echo "4.2: incorrect, missing \"data_gen.sh\" script on the SSH server (+$GRADE_42 pt)"
else
  GRADE_42=2.5
  echo "4.2: correct (+$GRADE_42 pt)"
fi

GRADE=$(bc <<< "$GRADE + $GRADE_42")

# 4.3
GRADE_43=0.0
if [ -d "/home/$1/assign6_output" ]; then
  GRADE_43=2.5
  echo "4.3: correct (+$GRADE_43 pt)"
else
  echo "4.3: incorrect, missing \"~/assign6_output\" directory on the SSH server (+$GRADE_43 pt)"
fi

GRADE=$(bc <<< "$GRADE + $GRADE_43")

# 4.4
GRADE_44=0.0
FIND_44="$(find "/home/$1" -type f \( -name "assign*.tar.gz" -o -name "assign*.tgz" -o -name "assign*.tar.gzip" \) 2>/dev/null)"
if [ -z "$FIND_44" ]; then
  echo "4.4: incorrect, missing \"tar gzip\" file on the SSH server (+$GRADE_44 pt)"
else
  GRADE_44=2.5
  echo "4.4: correct (+$GRADE_44 pt)"
fi

GRADE=$(bc <<< "$GRADE + $GRADE_44")

# 4.5
echo "4.5: GRADER: check attached file on Sakai"
GRADE_45=2.5

# TOTAL
echo "---------------------------"
echo "TOTAL: $GRADE pt if file IS NOT attached in Sakai"
GRADE=$(bc <<< "$GRADE + $GRADE_45")
echo "TOTAL: $GRADE pt if file IS attached in Sakai"
