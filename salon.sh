#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo "Welcome to My Salon, how can I help you?\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "1) cut\n2) color\n3) perm\n3) perm\n4) style\n5) trim"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) CREATE_APPOINTMENT ;;
    2) CREATE_APPOINTMENT ;;
    3) CREATE_APPOINTMENT ;;
    4) CREATE_APPOINTMENT ;;
    5) CREATE_APPOINTMENT ;;
    *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac
}

CREATE_APPOINTMENT() {

SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

# get customer info
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE

CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

# if customer doesn't exist
if [[ -z $CUSTOMER_NAME ]]
then
	# get new customer name
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
	# insert new customer
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
fi

# format SERVICE_NAME=SC, CUSTOMER_NAME=CN
SN=$(echo $SERVICE_NAME | sed -r 's/^ *| *$//g')
CN=$(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')

# get time
echo -e "\nWhat time would you like your $SN, $CN?"
read SERVICE_TIME

# get customer id
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

# insert appointment
INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")


# format SERVICE_TIME=ST
ST=$(echo $SERVICE_TIME | sed -r 's/^ *| *$//g')

echo -e "\nI have put you down for a $SN at $ST, $CN."
exit 0 

}

MAIN_MENU
