SELECT pl1.cargo, pl1.id_lider, pl1.id_pers, pl1.id_lugarfallec
FROM paises_lideres pl1
WHERE
    EXISTS (
            SELECT
                pl2.cargo,
                pl2.id_lider,
                pl2.id_pers,
                pl2.id_lugarfallec
            FROM
                paises_lideres as pl2
            WHERE
                pl1.cargo = pl2.cargo
                AND pl1.id_lider = pl2.id_lider
                AND pl1.id_pers = pl2.id_pers
                AND pl1.id_lugarfallec = pl2.id_lugarfallec
                AND (
                    pl1.id_pais <> pl2.id_pais
                    OR pl1.n_pais <> pl2.n_pais
                    OR pl1.d_pais <> pl2.d_pais
                    OR pl1.id_capital <> pl2.id_capital
                    OR pl1.n_capital <> pl2.n_capital
                    OR pl1.d_capital <> pl2.d_capital
                    OR pl1.n_lider <> pl2.n_lider
                    OR pl1.bio_lider <> pl2.bio_lider
                    OR pl1.id_ciudad <> pl2.id_ciudad
                    OR pl1.n_ciudad <> pl2.n_ciudad
                    OR pl1.d_ciudad <> pl2.d_ciudad
                    OR pl1.fecha_nac <> pl2.fecha_nac
                    OR pl1.fecha_fallec <> pl2.fecha_fallec
                    OR pl1.tipo_lugarfallec <> pl2.tipo_lugarfallec
                    OR pl1.n_lugarfallec <> pl2.n_lugarfallec
                )
        );




