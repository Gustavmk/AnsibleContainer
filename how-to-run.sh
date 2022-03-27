 #!/bin/sh
 
 docker run -v ${pwd}:/work:ro --env-file ${pwd}/.env.local --rm gustavmk/ansiblecontainer:latest "./auth_azcli.sh ; ansible-inventory -i inventory/in-azure_rm.yml --list"
