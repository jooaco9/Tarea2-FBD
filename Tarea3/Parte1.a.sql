-- Sin GROUP BY
SELECT X
FROM R AS r1
WHERE EXISTS (
    SELECT 1
    FROM R AS r2
    WHERE r1.X = r2.X
    AND r1.Y <> r2.Y
);

-- Comparo la tabla R consigo misma (r1 y r2). Para cada valor de X,
-- busco si existe alguna otra fila con el mismo valor de X pero con 
-- un valor diferente de Y. Si encuenta alguna, devuelve el valor de 
-- X, indicando ue la dependencia funcional no se cumple.

-- Con GROUP BY
SELECT X
FROM R
GROUP BY X
HAVING COUNT(DISTINCT Y) > 1;

-- Agrupo por X y verifico si hay mas de un valor distinto de Y 
-- para cada grupo de X. Si el numero de valores distintos de Y
-- es mayor que 1, significa que la dependencia funcional no se cumple 
-- para esos valores de X.

-- Parte 1.b.i
select pl.id_lugarfallec
from paises_lideres pl 
GROUP BY pl.id_lugarfallec
HAVING COUNT(DISTINCT pl.tipo_lugarfallec || ' ' || pl.n_lugarfallec) > 1;
-- Da vacio

-- Parte 1.b.ii
select pl.id_pers, pl.tipo_lugarfallec
from paises_lideres pl 
GROUP BY pl.id_pers, pl.tipo_lugarfallec
HAVING COUNT(DISTINCT pl.id_lugarfallec) > 1;
-- Da una tupla

-- Parte 1.b.iii
select pl.id_pers
from paises_lideres pl 
GROUP BY pl.id_pers
HAVING COUNT(DISTINCT pl.n_pers || ' ' || pl.fecha_nac || ' ' || pl.fecha_fallec) > 1;
-- Da 17 tuplas
