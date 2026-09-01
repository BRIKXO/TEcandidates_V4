# Usar Ubuntu 20.04 como base
FROM ubuntu:20.04

# Evitar preguntas interactivas durante la instalación de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    bzip2 \
    ca-certificates \
    time \
    libncurses5 \
    openjdk-8-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# Instalar Miniconda3
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

ENV PATH=/opt/conda/bin:$PATH

# Configurar canales de conda (eliminar defaults, agregar solo los necesarios)
RUN conda config --remove-key channels
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda
RUN conda config --set channel_priority strict

# Copiar el archivo de entorno y crear el entorno conda
COPY environment.yml /tmp/environment.yml

# Aceptar los Términos de Servicio de los canales por defecto de Anaconda
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

RUN conda env create -f /tmp/environment.yml && conda clean -a -y

# Activar el entorno por defecto
ENV PATH=/opt/conda/envs/tecandidates/bin:$PATH

# Copiar el script del pipeline
COPY TEcandidatesV4.sh /usr/local/bin/TEcandidates.sh
RUN chmod +x /usr/local/bin/TEcandidates.sh

# Definir el directorio de trabajo
WORKDIR /workspace

# Punto de entrada
ENTRYPOINT ["/usr/local/bin/TEcandidates.sh"]
