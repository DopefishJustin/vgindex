CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;

CREATE OR REPLACE FUNCTION public.unaccent_lower(TEXT) RETURNS TEXT
    LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT
    SET search_path = pg_catalog, public
    AS $$
        SELECT lower(public.unaccent($1))
    $$;

CREATE INDEX idx_discs_title_unaccent_trgm
ON discs USING GIN (public.unaccent_lower(title) gin_trgm_ops);

CREATE INDEX idx_discs_title_foreign_unaccent_trgm
ON discs USING GIN (public.unaccent_lower(title_foreign) gin_trgm_ops);
