for arg in "$@"; do
  shift
  case ${arg} in
    "-mongo6") set -- "$@" "-m" ;;
    "-mongo4") set -- "$@" "-z" ;;
    "-go") set -- "$@" "-g" ;;
    *)        set -- "$@" "$arg"
  esac
done

while getopts "mg" option; do
    case ${option} in
        m)
                echo "Starting the installation of Mongo 6.0...\nAdding key\n\n"
                sleep 2
                sudo apt-get install gnupg
                wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/server-6.0.gpg
                echo "\n\nCreating list file...\n\n"
                sleep 2
                touch /etc/apt/sources.list.d/mongodb-org-6.0.list
                echo "deb [ arch=amd64,arm64  signed-by=/usr/share/keyrings/server-6.0.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
                sleep 2
                echo "\n\nUpdating Packages...\n\n"
                sleep 2
                sudo apt-get update
                echo "\n\nActually installing mongo!\n\n"
                sleep 2
                sudo apt-get install -y mongodb-org
                sleep 2
                read -p "Mongo installation finished - Do you want to start the Mongo service? (y/n): " answer
                if [ "$answer" == "y" ]; then
                    sudo systemctl start mongod
                fi
            ;;
        z)
                echo "Starting the installation of Mongo 4.4...\nAdding key\n\n"
                sleep 2
                sudo apt-get install gnupg
                wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo gpg --dearmor -o /usr/share/keyrings/server-4.4.gpg
                echo "\n\nCreating list file...\n\n"
                sleep 2
                touch /etc/apt/sources.list.d/mongodb-org-4.4.list
                echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/server-4.4.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
                sleep 2
                echo "\n\nUpdating Packages...\n\n"
                sleep 2
                sudo apt-get update
                echo "\n\nActually installing mongo!\n\n"
                sleep 2
                sudo apt-get install -y mongodb-org
                sleep 2
                read -p "Mongo installation finished - Do you want to start the Mongo service? (y/n): " answer
                if [ "$answer" == "y" ]; then
                    sudo systemctl start mongod
                fi
            ;;
        g)
              echo "Starting the installation of GoLang 1.20.4\n"
              wget "https://go.dev/dl/go1.20.4.linux-amd64.tar.gz"
              sudo tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
              rm go1.20.4.linux-amd64.tar.gz
              read -p "GoLang needs to be manually added to the path please enter the file that your terminal sources for login sessions (~/.bash_profile, ~/.zprofile, etc): " prof
              echo "PATH=$PATH:/usr/local/go/bin" >> "$prof"
              source "$prof"
           ;;
        ?)
            break
            ;;
    esac
done
