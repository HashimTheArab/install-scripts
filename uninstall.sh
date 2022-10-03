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
                echo "Unisntalling Mongo 6.0 Repository\n"
                sudo apt purge mongodb-org
                read -p "Do you wish to remove the MongoDB keys and repos? (y/n): " answer
                if [ "$answer" == "y" ]; then
                echo "Removing List Entry\n"
                sudo rm /etc/apt/sources.list.d/mongodb-org-6.0.list
                echo "Removing mongodb keys\n"
                sudo rm /usr/share/keyrings/server-6.0.gpg
                fi
                echo "MongoDB has successfully been uninstalled.\n"
            ;;
        z)
                echo "Unisntalling Mongo 4.4 Repository\n"
                sudo apt purge mongodb-org
                read -p "Do you wish to remove the MongoDB keys and repos? (y/n): " answer
                if [ "$answer" == "y" ]; then
                echo "Removing List Entry\n"
                sudo rm /etc/apt/sources.list.d/mongodb-org-4.4.list
                echo "Removing mongodb keys\n"
                sudo rm /usr/share/keyrings/server-4.4.gpg
                fi
                echo "MongoDB has successfully been uninstalled.\n"
            ;;
        g)
              echo "Removing local go bin.\n"
              rm -rf /usr/local/go
              echo "Note this does not remove the entry to your path.\n"
           ;;
        ?)
            break
            ;;
    esac
done
