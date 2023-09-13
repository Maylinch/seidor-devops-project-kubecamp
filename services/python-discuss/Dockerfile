# Etapa 1: Construir la aplicación
FROM mcr.microsoft.com/devcontainers/python:3.10-bullseye as build

# Instala Poetry
RUN pip install poetry

# Establecer el directorio de trabajo
WORKDIR /app

# Copia los archivos de la aplicación (incluyendo pyproject.toml y poetry.lock)
COPY . .

# Instala las dependencias de desarrollo y producción con Poetry
RUN poetry install

# Etapa 2: Crear la imagen de producción
FROM python:3.10-slim-bullseye as production

# Establecer el directorio de trabajo
WORKDIR /app

# Copia solo los archivos necesarios para la ejecución de la aplicación
COPY --from=build /app/src /app

# Instala las dependencias de producción
RUN pip install fastapi uvicorn pymongo python-dotenv pydantic typing requests

# CMD para ejecutar el script principal de Python
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8083"]
