-- 1. a. i) X -> Y sin grroup by
-- Si se cumple la dependencia devuelve vacio
-- Si se cumple la dependencia entonces el exist no se cumple
SELECT
    X
FROM
    R as r1
WHERE
    EXISTS (
        SELECT
            Y
        FROM
            R as r2
        WHERE
            r1.X = r2.X
            AND r1.Y <> r2.Y
    );

-- 1. a. ii) X -> Y con group by
-- Si se cumple la dependencia devuelve vacio
-- Agrupo los elementos por X y solo se devuelven
-- las tuplas con mas de un elemento Y para ese X
SELECT
    X
FROM
    R
GROUP BY
    X
HAVING
    COUNT(DISTINCT Y) > 1;

-- 1. b. i) Aplicando 1. a. i)
SELECT
    pl1.id_lugarfallec
FROM
    paises_lideres as pl1
WHERE
    EXISTS (
        SELECT
            pl2.tipo_lugarfallec,
            pl2.n_lugarfallec
        FROM
            paises_lideres as pl2
        WHERE
            pl1.id_lugarfallec = pl2.id_lugarfallec
            AND (
                pl1.tipo_lugarfallec <> pl2.tipo_lugarfallec
                OR pl1.n_lugarfallec <> pl2.n_lugarfallec
            )
    );

-- 1. b. ii) Aplicando 1. a. i)
SELECT
    pl1.id_pers,
    pl1.tipo_lugarfallec
FROM
    paises_lideres as pl1
WHERE
    EXISTS(
        SELECT
            pl2.id_lugarfallec
        FROM
            paises_lideres as pl2
        WHERE
                pl1.id_pers = pl2.id_pers
                AND pl1.tipo_lugarfallec = pl2.tipo_lugarfallec
                AND	pl1.id_lugarfallec <> pl2.id_lugarfallec
    );

-- 1. b. iii) Aplicando 1. a. i)
SELECT
    DISTINCT id_pers
FROM
    paises_lideres as pl1
WHERE
    EXISTS(
        SELECT
            n_pers,
            fecha_nac,
            id_lugarfallec
        FROM
            paises_lideres as pl2
        WHERE
            pl1.id_pers = pl2.id_pers
            AND (
                pl1.n_pers <> pl2.n_pers
                OR pl1.fecha_nac <> pl2.fecha_nac
                OR pl1.id_lugarfallec <> pl2.id_lugarfallec
            )
    );	

-- 1. b. i) Aplicando 1. a. ii)
SELECT
    id_lugarfallec
FROM
    paises_lideres
GROUP BY
    id_lugarfallec
HAVING
    COUNT(DISTINCT id_lugarfallec) > 1
    AND COUNT(DISTINCT tipo_lugarfallec) > 1;

-- 1. b. ii) Aplicando 1. a. ii)
SELECT
    id_pers,
    tipo_lugarfallec
FROM
    paises_lideres
GROUP BY
    id_pers,
    tipo_lugarfallec
HAVING
    COUNT(DISTINCT id_lugarfallec) > 1;

-- 1. b. iii) Aplicando 1. a. ii)
SELECT
    id_pers
FROM
    paises_lideres
GROUP BY
    id_pers
HAVING
    (
        COUNT(DISTINCT n_pers) > 1
        OR COUNT(DISTINCT fecha_nac) > 1
        OR COUNT(DISTINCT id_lugarfallec) > 1
    );
    
/*
	1.c) La consulta (i) se mantuvo sin resultados
		 La consulta (ii) y la consulta (iii) dan diferentes resultados en la consulta que tiene group by de la que no
		 En la que tiene group by devuelve resultados nulos, supongo que tiene que ver con la naturaleza del group by
		 ya que en las consultas sin el group by se hacen las comparaciones especificamente basadas en el atributo
*/;

-- 1. d. i) Sin group by
SELECT
    X, Y
FROM
    R as r1
WHERE
    EXISTS (
    	SELECT 
    		Y 
    	FROM 
    		R as r2
        WHERE
            r1.X = r2.X
            AND r1.Y <> r2.Y
    );

SELECT
	pl1.id_pers, pl1.tipo_lugarfallec, pl1.id_lugarfallec
FROM
	paises_lideres as pl1
WHERE
	EXISTS (
		SELECT
			pl2.id_lugarfallec
		FROM
			paises_lideres as pl2
		WHERE
			pl1.id_pers = pl2.id_pers
			AND pl1.tipo_lugarfallec = pl2.tipo_lugarfallec
			AND pl1.id_lugarfallec <> pl2.id_lugarfallec
	);

-- 1. d. ii) Con group by
SELECT
	r1.X, r1.Y
FROM
	R as r1
JOIN (
	SELECT
		r2.X
	FROM
		R as r2
	GROUP BY
		X
	HAVING COUNT(DISTINCT Y) > 1
) as R3
ON r1.X = r2.X
;

SELECT
	pl.id_pers, pl.tipo_lugarfallec, pl.id_lugarfallec
FROM
	paises_lideres as pl
JOIN (
	SELECT
		pl2.id_pers, pl2.tipo_lugarfallec
	FROM
		paises_lideres as pl2
	GROUP BY
		pl2.id_pers, pl2.tipo_lugarfallec
	HAVING COUNT(DISTINCT pl2.id_lugarfallec) > 1
) as sq
ON pl.id_pers = sq.id_pers
AND pl.tipo_lugarfallec = sq.tipo_lugarfallec
;