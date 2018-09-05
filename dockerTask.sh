imageName="sql_server"
containerName="${imageName}_azure"
workdir="./"

# Kills all containers based on the image
killContainers () {
  echo "Matando todos os containers com o nome ${imageName} ."
  docker rm -f $(docker ps -q -a -f name=${imageName})
}

# Removes the Docker image
removeImage () {
  imageId=$(docker images -q ${imageName})
  if [[ -z ${imageId} ]]; then
    echo "${imageName} não encontrada."
  else
    echo "Removendo a imagem ${imageName}"
    docker rm ${imageId}
  fi
}

# Builds the Docker image.
buildImage () {
  dockerFileName="Dockerfile"
  if [[ ! -f "$workdir/$dockerFileName" ]]; then
    echo "Arquivo '$dockerFileName' não encontrado."
  else
    echo "Building the image $imageName ($ENVIRONMENT)."
    docker build -t $imageName -f "$workdir/$dockerFileName" $workdir
  fi
}

# Runs a new container
runContainer () {
    echo "Rodando um novo container $containerName"
    if [[ -z $(docker images -q $imageName) ]]; then
        echo "Imagem com nome $imageName não encontrada"
    else
        docker run --rm --net="host" -it --name $containerName $imageName
    fi
}

# Shows the usage for the script.
showUsage () {
  echo "Usage: dockerTask.sh [COMMAND]"
  echo "    Comandos"
  echo ""
  echo "Comandos:"
  echo "    copy: Copia o arquivo bak do novo inscricao."
  echo "    cls: Remove a imagem: '$imageName' e remove todas as images com esse nome."
  echo "    build: Build a imagem e roda."
  echo ""
  echo "Exemplo:"
  echo "    ./dockerTask.sh build"
  echo ""
  echo "    Irá acontecer:"
  echo "        Build a imagem Docker com nome $imageName ."
  read
}

if [ $# -eq 0 ]; then
  showUsage
else
  case "$1" in
    "cls")
            killContainers
            ;;
    "build")
            killContainers
            buildImage
            runContainer
            ;;
    *)
            showUsage
            ;;
  esac
fi
read