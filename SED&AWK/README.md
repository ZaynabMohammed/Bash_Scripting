# Practice Excercies on SED&AWK
## Using sed utility
  1- Display the lines that contain the word "lp" in /etc/passwd file.
    ```
      sed -ne '/^lp/ p' /etc/passwd
    ```
  2- Display/etc/passwd file except the third line.
    ```
       sed -n '3!p' /etc/passwd
    ```
  3- Display/etc/passwd file except the last line.
      ```
         sed ' $d' /etc/passwd
      ```
  4- Display/etc/passwd file except the lines that contain the word "lp".
      ```
         sed -ne '/^lp/ !p' /etc/passwd
      ```
  5- Substitute all the words that contain "lp" with "mylp" in /etc/passwd file.
      ```
         sed 's/lp/mylp/' /etc/passwd
         sed 's/lp/mylp/g' /etc/passwd   ------> With g as global
      ```
##  Using awk utility
  1- Print full name (comment) of all users in the system.
      ```
         awk -F':' '{print $5}' /etc/passwd
      ```
  2- Print login, full name (comment) and home directory of all users. (Print each line preceded by a line number)
      ```
         awk -F':' '{print NR, $1, $5, $6}'/etc/passwd
      ```
  3- Print login, uid and full name (comment) of those uid is greater than 500
      ```
         awk -F':' '{for(i=1;i<=NF; i++) { if (i==3 && $i > 500) {print $1,$3,$5} } }' /etc/passwd
      ```
  4- Print login, uid and full name (comment) of those uid is exactly 500
      ```
         awk -F':' '{for(i=1;i<=NF; i++) { if (i==3 && $i == 500) {print $1,$3,$5} } }' /etc/passwd
      ```
  5- Print line from 5 to 15 from /etc/passwd
      ```
         awk -F':' '{for(i=5; i<=15; i++) { if (i == NR) {print NR, $0}}}'/etc/passwd
      ```
  6- Change lp to mylp
      ```
          awk -F':' '{for(i=1; i<=NF; i++) { if ((i==1 || i==5) && $i == "lp") {$i="mylp"; print $0}}}'/etc/passwd
      ```
  7- Print all information about greatest uid.
      ```
         awk -F':' '{for(i=1; i<=NF; i++) { if (i==3 && $i max) {max=$i} }} END {print max}' /etc/passwd
      ```
  8- Get the sum of all accounts id's.
      ```
        awk -F':' '{for(i=1; i<=NF; i++) { if (i==3) {sum+=$i} }} END {print sum}' /etc/passwd
      ```
