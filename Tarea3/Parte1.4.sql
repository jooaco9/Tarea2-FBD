-- Parte 1.4a: Crear nueva tabla pa_li2
DROP TABLE IF EXISTS pa_li2;
CREATE TABLE pa_li2 (LIKE paises_lideres INCLUDING ALL);

-- Parte 1.4b: Agregar clave primaria usando la clave alternativa
ALTER TABLE pa_li2 ADD PRIMARY KEY (cargo, id_lider, id_pers, id_lugarfallec);

-- Parte 1.4c: Insertar datos manejando conflictos y nulos
-- Creacion de sequencias autoincrementales para cada uno de los atributos de la clave
CREATE SEQUENCE cargo_seq;
CREATE SEQUENCE lider_seq;
CREATE SEQUENCE pers_seq;
CREATE SEQUENCE lugarfallec_seq;

INSERT INTO pa_li2
SELECT 
    COALESCE(id_pais, 'PAIS-DEFAULT') AS id_pais,
    COALESCE(n_pais, 'Nombre país no especificado') AS n_pais,
    COALESCE(d_pais, 'Descripción país no especificada') AS d_pais,
    COALESCE(id_capital, 'CAP-DEFAULT') AS id_capital,
    COALESCE(n_capital, 'Nombre capital no especificado') AS n_capital,
    COALESCE(d_capital, 'Descripción capital no especificada') AS d_capital,
    CASE 
        WHEN cargo IS NULL THEN CAST(nextval('cargo_seq') AS TEXT)
        ELSE cargo 
    END AS cargo,
    CASE 
        WHEN id_lider IS NULL THEN CAST(nextval('lider_seq') AS TEXT) 
        ELSE id_lider 
    END AS id_lider,
    COALESCE(n_lider, 'Nombre líder no especificado') AS n_lider,
    COALESCE(bio_lider, 'Biografía líder no especificada') AS bio_lider,
    COALESCE(id_ciudad, 'CIU-DEFAULT') AS id_ciudad,
    COALESCE(n_ciudad, 'Nombre ciudad no especificado') AS n_ciudad,
    COALESCE(d_ciudad, 'Descripción ciudad no especificada') AS d_ciudad,
    CASE 
        WHEN id_pers IS NULL THEN CAST(nextval('pers_seq') AS TEXT) 
        ELSE id_pers 
    END AS id_pers,
    COALESCE(n_pers, 'Nombre persona no especificado') AS n_pers,
    COALESCE(fecha_nac, 'Fecha de nacimiento no especificada') AS fecha_nac,
    COALESCE(fecha_fallec, 'Fecha de fallecimiento no especificada') AS fecha_fallec,
    CASE 
        WHEN id_lugarfallec IS NULL THEN CAST(nextval('lugarfallec_seq') AS TEXT)
        ELSE id_lugarfallec 
    END AS id_lugarfallec,
    COALESCE(tipo_lugarfallec, 'No especificado') AS tipo_lugarfallec,
    COALESCE(n_lugarfallec, 'Nombre lugar fallecimiento no especificado') AS n_lugarfallec
FROM paises_lideres
ON CONFLICT (cargo, id_lider, id_pers, id_lugarfallec) 
DO NOTHING;

-- Consultas para verificar la carga y posibles diferencias
SELECT COUNT(*) as total_registros FROM pa_li2;
SELECT COUNT(*) as registros_originales FROM paises_lideres;