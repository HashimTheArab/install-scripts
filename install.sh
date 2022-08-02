for arg in "$@"; do
  shift
  case ${arg} in
    "-mongo") set -- "$@" "-m" ;;
    "-go") set -- "$@" "-g" ;;
    *)        set -- "$@" "$arg"
  esac
done

while getopts "mg" option; do
    case ${option} in
        m)
                echo "Starting the installation of Mongo...\nAdding key\n\n"
                sleep 2
                sudo apt-get install gnupg
                wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
                echo "\n\nCreating list file...\n\n"
                sleep 2
                touch /etc/apt/sources.list.d/mongodb-org-6.0.list
                echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
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
              echo "Starting the installation of GoLang 1.19\n"
              wget "https://go.dev/dl/go1.19.linux-amd64.tar.gz"
              sudo tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz
              rm go1.19.linux-amd64.tar.gz
              echo "PATH=$PATH:/usr/local/go/bin" >> ~/.profile
              source ~/.profile
           ;;
        ?)
            break
            ;;
    esac
done
