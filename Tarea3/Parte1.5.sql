CREATE OR REPLACE FUNCTION verificacion_de_clave_func()
RETURNS TRIGGER AS $$
DECLARE
  clave_duplicada BOOLEAN;
  clave_null BOOLEAN;
BEGIN
  -- Verificar si ya existe un registro con la misma clave
  clave_duplicada := EXISTS (
    SELECT 1 
    FROM pa_li3 pl
    WHERE pl.cargo = NEW.cargo
      AND pl.id_lider = NEW.id_lider
      AND pl.id_pers = NEW.id_pers
      AND pl.id_lugarfallec = NEW.id_lugarfallec
  );

  -- Verificar si alguna clave es NULL
  clave_null := (NEW.cargo IS NULL)
    OR (NEW.id_lider IS NULL)
    OR (NEW.id_pers IS NULL)
    OR (NEW.id_lugarfallec IS NULL);

  -- Insertar en aux_pl si la clave es duplicada o contiene NULL
  IF clave_duplicada OR clave_null THEN
    INSERT INTO aux_pl (
      cargo,
      id_lider,
      id_pers,
      id_lugarfallec,
      id_pais, 
      n_pais,
      d_pais,
      id_capital,
      n_capital,
      d_capital,
      n_lider,
      bio_lider,
      id_ciudad,
      n_ciudad,
      d_ciudad,
      fecha_nac,
      fecha_fallec,
      tipo_lugarfallec,
      n_lugarfallec
    ) VALUES (
      NEW.cargo,
      NEW.id_lider,
      NEW.id_pers,
      NEW.id_lugarfallec,
      NEW.id_pais, 
      NEW.n_pais,
      NEW.d_pais,
      NEW.id_capital,
      NEW.n_capital,
      NEW.d_capital,
      NEW.n_lider,
      NEW.bio_lider,
      NEW.id_ciudad,
      NEW.n_ciudad,
      NEW.d_ciudad,
      NEW.fecha_nac,
      NEW.fecha_fallec,
      NEW.tipo_lugarfallec,
      NEW.n_lugarfallec
    );
    RETURN NULL;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que llama a la función
CREATE TRIGGER verificacion_de_clave
BEFORE INSERT ON pa_li3
FOR EACH ROW
EXECUTE FUNCTION verificacion_de_clave_func();

INSERT INTO pa_li3
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
    COALESCE(fecha_nac, '1900-01-01') as fecha_nac,
    COALESCE(fecha_fallec, '2024-01-01') as fecha_fallec,
    id_lugarfallec,  -- parte de PK
    COALESCE(tipo_lugarfallec, 'No especificado') as tipo_lugarfallec,
    COALESCE(n_lugarfallec, 'Nombre lugar fallecimiento no especificado') as n_lugarfallec
FROM paises_lideres




