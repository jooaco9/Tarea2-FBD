-- Parte 1.4a: Crear nueva tabla pa_li2
DROP TABLE IF EXISTS pa_li2;
CREATE TABLE pa_li2 (LIKE paises_lideres INCLUDING ALL);

-- Parte 1.4b: Agregar clave primaria usando la clave alternativa
ALTER TABLE pa_li2 ADD PRIMARY KEY (cargo, id_lider, id_pers, id_lugarfallec);

-- Parte 1.4c: Insertar datos manejando conflictos y nulos
INSERT INTO pa_li2
SELECT 
    COALESCE(id_pais, 'PAIS-DEFAULT') as id_pais,
    COALESCE(n_pais, 'Nombre país no especificado') as n_pais,
    COALESCE(d_pais, 'Descripción país no especificada') as d_pais,
    COALESCE(id_capital, 'CAP-DEFAULT') as id_capital,
    COALESCE(n_capital, 'Nombre capital no especificado') as n_capital,
    COALESCE(d_capital, 'Descripción capital no especificada') as d_capital,
    cargo,      -- parte de PK
    id_lider,   -- parte de PK
    COALESCE(n_lider, 'Nombre líder no especificado') as n_lider,
    COALESCE(bio_lider, 'Biografía líder no especificada') as bio_lider,
    COALESCE(id_ciudad, 'CIU-DEFAULT') as id_ciudad,
    COALESCE(n_ciudad, 'Nombre ciudad no especificado') as n_ciudad,
    COALESCE(d_ciudad, 'Descripción ciudad no especificada') as d_ciudad,
    id_pers,    -- parte de PK
    COALESCE(n_pers, 'Nombre persona no especificado') as n_pers,
    COALESCE(fecha_nac, 'Fecha de nacimineto no especificada') as fecha_nac,
    COALESCE(fecha_fallec, 'Fecha de fallecimiento no especificada') as fecha_fallec,
    id_lugarfallec,  -- parte de PK
    COALESCE(tipo_lugarfallec, 'No especificado') as tipo_lugarfallec,
    COALESCE(n_lugarfallec, 'Nombre lugar fallecimiento no especificado') as n_lugarfallec
FROM paises_lideres
WHERE 
	cargo IS NOT NULL AND
	id_lider IS NOT NULL AND
	id_pers IS NOT NULL AND
	id_lugarfallec IS NOT NULL
ON CONFLICT (cargo, id_lider, id_pers, id_lugarfallec) 
DO NOTHING;

-- Consultas para verificar la carga y posibles diferencias
SELECT COUNT(*) as total_registros FROM pa_li2;
SELECT COUNT(*) as registros_originales FROM paises_lideres;