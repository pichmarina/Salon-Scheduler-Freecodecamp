#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo "Welcome to My Salon, how can I help you?"

MAIN_MENU() {
    # Display services
    SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
    echo "$SERVICES" | while read SERVICE_ID BAR NAME
    do
        echo "$SERVICE_ID) $NAME"
    done

    # Get service selection
    read SERVICE_ID_SELECTED

    # Validate service exists
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    if [[ -z $SERVICE_NAME ]]
    then
        MAIN_MENU
    else
        # Get customer phone
        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE

        # Check if customer exists
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
        
        # If customer doesn't exist
        if [[ -z $CUSTOMER_ID ]]
        then
            echo -e "\nI don't have a record for that phone number, what's your name?"
            read CUSTOMER_NAME
            # Insert new customer
            INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
            CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
        else
            # Get existing customer name
            CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
        fi

        # Get appointment time
        echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed 's/ //g'), $(echo $CUSTOMER_NAME | sed 's/ //g')?"
        read SERVICE_TIME

        # Insert appointment
        INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

        # Confirm appointment
        echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed 's/ //g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed 's/ //g')."
    fi
}

MAIN_MENU
