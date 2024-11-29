FROM continuumio/miniconda3:latest

# Configurar el PATH para conda
ENV PATH="/opt/conda/bin:$PATH"

# Crear el entorno en Conda
RUN conda create -n myenv python=3.9 -y

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo requirements.txt al contenedor
COPY requirements.txt /app/



# Instalar las dependencias en el entorno Conda utilizando conda run
RUN conda run -n myenv pip install -r /app/requirements.txt

RUN conda run -n myenv conda install -c conda-forge ta-lib

# Copiar el resto del proyecto
COPY . /app/

# Configurar el comando de inicio con activación del entorno
CMD ["conda", "run", "-n", "myenv", "python", "manage.py", "runserver", "0.0.0.0:8000"]
