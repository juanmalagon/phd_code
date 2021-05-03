SELECT lit_review.wos_2020_11_29.id, lit_review.econlit_2020_11_29.id, lit_review.wos_2020_11_29.ISSN, lit_review.econlit_2020_11_29."header/controlInfo/jinfo/issn/__text"
FROM lit_review.wos_2020_11_29 
full OUTER JOIN lit_review.econlit_2020_11_29
ON LEFT(lit_review.wos_2020_11_29.ISSN,4) = LEFT(lit_review.econlit_2020_11_29."header/controlInfo/jinfo/issn/__text" ,4)
and RIGHT(lit_review.wos_2020_11_29.ISSN,4) = RIGHT(lit_review.econlit_2020_11_29."header/controlInfo/jinfo/issn/__text" ,4);


-- wos
select lit_review.wos_2020_11_29.*, lit_review.wos_2020_11_25.about_education 
from lit_review.wos_2020_11_29
left join lit_review.wos_2020_11_25
on lit_review.wos_2020_11_29."UT (Unique WOS ID)" = lit_review.wos_2020_11_25."UT (Unique WOS ID)";

-- econlit
select lit_review.econlit_2020_11_29.*, lit_review.econlit_2020_11_25.about_education, lit_review.econlit_2020_11_25.real_lang 
from lit_review.econlit_2020_11_29
left join lit_review.econlit_2020_11_25
on lit_review.econlit_2020_11_29."header/_uiTerm" = lit_review.econlit_2020_11_25."header/_uiTerm";

-- eric
select lit_review.eric_2020_11_29.*, lit_review.eric_2020_11_25.about_education, lit_review.eric_2020_11_25.real_lang, lit_review.eric_2020_11_25.latam
from lit_review.eric_2020_11_29
left join lit_review.eric_2020_11_25
on lit_review.eric_2020_11_29."header/_uiTerm" = lit_review.eric_2020_11_25."header/_uiTerm";

-- wos_slim

CREATE OR REPLACE VIEW lit_review.wos_sum
AS select
	'WOS' as "DATABASE",
	"UT (Unique WOS ID)" as "IDI",
	wos."Publication Year" AS "YEAR",
    upper(wos."Source Title"::text) AS "JOURNAL",
    upper(wos."Author Full Names"::text) AS "AUTHOR",
    upper(wos."Article Title"::text) AS "TITLE",
    upper(wos."Language"::text) AS "LANGUAGE",
    upper(wos."Research Areas"::text) AS "AREA_0",
    upper("WoS Categories") as "AREA_1",
    null as "AREA_2",
    upper(wos.abstract::text) AS "ABSTRACT",
    upper(wos.about_education::text) AS "ABOUT_EDU",
    null as "LATAM",
    wos."Times Cited, All Databases" AS "CITED_BY"
   FROM lit_review.wos;


-- econlit_slim
CREATE OR REPLACE VIEW lit_review.econlit_sum
AS SELECT upper(econlit."header/_longDbName"::text) AS "DATABASE",
    upper(econlit."header/_uiTerm"::text) AS "IDI",
    econlit."header/controlInfo/pubinfo/dt/_year" AS "YEAR",
    upper(econlit."header/controlInfo/jinfo/jtl"::text) AS "JOURNAL",
    concat(upper(econlit."header/controlInfo/artinfo/aug/au/0"::text), '; ', upper(econlit."header/controlInfo/artinfo/aug/au/1"::text), '; ', upper(econlit."header/controlInfo/artinfo/aug/au/2"::text), '; ', upper(econlit."header/controlInfo/artinfo/aug/au/3"::text), '; ', upper(econlit."header/controlInfo/artinfo/aug/au/4"::text), '; ', upper(econlit."header/controlInfo/artinfo/aug/au/5"::text)) AS "AUTHOR",
    upper(econlit."header/controlInfo/artinfo/tig/atl"::text) AS "TITLE",
    upper(econlit.real_lang::text) AS "LANGUAGE",
    upper(econlit."header/controlInfo/artinfo/su/0"::text) AS "AREA_0",
    upper(econlit."header/controlInfo/artinfo/su/1"::text) AS "AREA_1",
    upper(econlit."header/controlInfo/artinfo/su/2"::text) AS "AREA_2",
    upper(econlit."header/controlInfo/artinfo/ab"::text) AS "ABSTRACT",
    upper(econlit.about_education::text) AS "ABOUT_EDU",
    null as "LATAM",
    null as "CITED_BY"
   FROM lit_review.econlit;

-- eric_slim
CREATE OR REPLACE VIEW lit_review.eric_sum
AS SELECT upper(eric."header/_longDbName"::text) AS "DATABASE",
    upper(eric."header/_uiTerm"::text) AS "IDI",
    eric."header/controlInfo/pubinfo/dt/_year" AS "YEAR",
    upper(eric."header/controlInfo/jinfo/jtl"::text) AS "JOURNAL",
    concat(upper(eric."header/controlInfo/artinfo/aug/au/0"::text), '; ', upper(eric."header/controlInfo/artinfo/aug/au/1"::text), '; ', upper(eric."header/controlInfo/artinfo/aug/au/2"::text), '; ', upper(eric."header/controlInfo/artinfo/aug/au/3"::text), '; ', upper(eric."header/controlInfo/artinfo/aug/au/4"::text), '; ', upper(eric."header/controlInfo/artinfo/aug/au/5"::text)) AS "AUTHOR",
    upper(eric."header/controlInfo/artinfo/tig/atl"::text) AS "TITLE",
    upper(eric.real_lang::text) AS "LANGUAGE",
    upper(eric."header/controlInfo/artinfo/su/0"::text) AS "AREA_0",
    upper(eric."header/controlInfo/artinfo/su/1"::text) AS "AREA_1",
    upper(eric."header/controlInfo/artinfo/su/2"::text) AS "AREA_2",    
    upper(eric."header/controlInfo/artinfo/ab"::text) AS "ABSTRACT",
    upper(eric.about_education::text) AS "ABOUT_EDU",
    upper(eric.latam::text) AS "LATAM",
    null as "CITED_BY"
   FROM lit_review.eric;



select *
from 
(
select lit_review.econlit_2020_11_29.*, lit_review.econlit_2020_11_25.about_education, lit_review.econlit_2020_11_25.real_lang 
from lit_review.econlit_2020_11_29
left join lit_review.econlit_2020_11_25
on lit_review.econlit_2020_11_29."header/_uiTerm" = lit_review.econlit_2020_11_25."header/_uiTerm"
) econlit
full outer join
(
select lit_review.eric_2020_11_29.*, lit_review.eric_2020_11_25.about_education, lit_review.eric_2020_11_25.real_lang, lit_review.eric_2020_11_25.latam
from lit_review.eric_2020_11_29
left join lit_review.eric_2020_11_25
on lit_review.eric_2020_11_29."header/_uiTerm" = lit_review.eric_2020_11_25."header/_uiTerm"
) eric
on upper(econlit."header/controlInfo/artinfo/tig/atl") = upper(eric."header/controlInfo/artinfo/tig/atl");


SELECT A."DATABASE", A."IDI", A."YEAR", A."JOURNAL", A."AUTHOR", A."TITLE", A."ABSTRACT", A."LATAM" 
FROM lit_review.econlit_sum A
inner join lit_review.lang_no_dup_about R
on A."IDI" = R."IDI"                                                            
union
SELECT A."DATABASE", A."IDI", A."YEAR", A."JOURNAL", A."AUTHOR", A."TITLE", A."ABSTRACT", A."LATAM"
FROM lit_review.eric_sum A
inner join lit_review.lang_no_dup_about R
on A."IDI" = R."IDI"                                                            
union
SELECT A."DATABASE", A."IDI", A."YEAR", A."JOURNAL", A."AUTHOR", A."TITLE", A."ABSTRACT", A."LATAM"
FROM lit_review.wos_sum A
inner join lit_review.lang_no_dup_about R
on A."IDI" = R."IDI";                                                            


lit_review.econlit_sum."IDI" in (select "IDI" from lit_review.lang_no_dup_about)
union 
SELECT "DATABASE", "IDI", "YEAR", "JOURNAL", "AUTHOR", "TITLE", "ABSTRACT", "LATAM"
FROM lit_review.eric_sum
where lit_review.eric_sum."IDI" in (select "IDI" from lit_review.lang_no_dup_about)
union 
SELECT "DATABASE", "IDI", "YEAR", "JOURNAL", "AUTHOR", "TITLE", "ABSTRACT", "LATAM"
FROM lit_review.wos_sum
where lit_review.wos_sum."IDI" in (select "IDI" from lit_review.lang_no_dup_about)
;

select a.*, b."﻿INCLUDE", b.reason 
from lit_review.lang_no_dup_about_edu a
left join lit_review.includes_csv b
on a.idi = b.idi;


