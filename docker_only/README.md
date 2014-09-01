### Specifying a secret key for graphite access

Prior to running the built graphite container, execute the following command, replacing `your-secret-key!`

    sudo mkdir -m 777 /local_auth && sudo echo "SECRET_KEY='your-secret-key!'" > /local_auth/__init__.py
