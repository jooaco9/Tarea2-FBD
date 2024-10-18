import psycopg2
import os

# Cambiar las siguientes constantes por las credenciales de la base
DB_NAME = 'tarea2' # nombre de la base
DB_HOST = 'localhost' # host de la base
DB_PORT = 5432 # puerto de la base, por defecto es 5432
DB_USER = 'postgres' # usuario 
DB_PASSWORD = 'admin' # contraseña

# Cambiar acá por el directorio donde están los archivos de las consultas
PATH_TO_QUERIES = 'C:/Users/User/Desktop/Facultad/FBD/Tareas/Tarea_2/lab2-2024-main/queries'

QUERIES = {
        'consulta1': 'name',
        'consulta2': 'name',
        'consulta3': 'name,duration,unit_price',
        'consulta4': 'first_name,last_name',
        'consulta5': 'first_name,last_name',
        'consulta6': 'first_name,last_name,number_of_purchases',
        'consulta7': 'name',
        'consulta8': 'title,number_of_purchases',
        'consulta9': 'employee_id,first_name,last_name'
    }


if "__main__":
    
    conn = psycopg2.connect(database=DB_NAME,
                            host=DB_HOST,
                            user=DB_USER,
                            password=DB_PASSWORD,
                            port=DB_PORT)
    
    with conn.cursor() as cur:

        for query_file, expected_fields in QUERIES.items():
            
            file_path = os.path.join(PATH_TO_QUERIES, query_file + '.sql')

            try:

                with open(file_path, mode='r', encoding='utf-8-sig') as file:

                    query_content = file.read().replace(';', '').replace('"', '')
                    query = f"SELECT {expected_fields} FROM ({query_content}) AS subquery"
                    cur.execute(query)

                    print(f'La {query_file} cumple con el esquema solicitado')
            
            except FileNotFoundError as fnf_error:
                print(f'No se encontró el archivo {query_file}')
            except psycopg2.Error as e:
                print(f'La {query_file} no cumple con el esquema solicitado. El esquema esperado es {expected_fields}')
            except Exception as ex:
                print(f'Error: {ex}')

    conn.close()
