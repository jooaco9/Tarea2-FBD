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
    DISTINCT pl1.id_pers,
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