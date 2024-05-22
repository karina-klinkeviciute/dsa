.. default-role:: literal
.. _dimensijos:

Dimensijos
==========

Demensijos leidžia vienoje lentelėje sutalpinti kelias skirtingas lenteles
turinčias bendrų savybių.

DSA lentelėje turime tokius dimensijų stulpelius:

- :ref:`dataset`
- :ref:`resource`
- :ref:`model`
- :ref:`property`

======= ======== ===== ============= ============================== 
dataset resource model property      title                         
======= ======== ===== ============= ============================== 
datasets/gov/rc/ar/ws                Duomenų rinkinys
------------------------------------ ------------------------------ 
\       db                           Duomenų teikimo paslauga
------- ---------------------------- ------------------------------ 
\                **Gyvenviete**      Esybė
------- -------- ------------------- ------------------------------ 
\                      pavadinimas   Savybė
======= ======== ===== ============= ============================== 

Pavyzdyje aukščiau turime tris lenteles, turinčias vieną bendrą stulpelį
`title`.

Daugiamatė lentelė pateikta viršuje, aitiktu toką vienamtę lentelę:

========== ===================== ============================== 
type       name                  title  
========== ===================== ============================== 
dataset    datasets/gov/rc/ar/ws Duomenų rinkinys
resource   db                    Duomenų teikimo paslauga
model      **Gyvenviete**        Esybė
property   pavadinimas           Savybė
========== ===================== ============================== 

Kadangi DSA lentelė yra daugiamatę, nurodant stuleplį, jei kalbama apie
konkrečios dimensijos stulpelį, reikia nurodyti ir dimensiją, pavyzdžiui
`dataset.title` nurodo būtent apie `dataset` diemensijos `title` stulpelį.



.. _dataset:

dataset
-------

.. module:: dataset

Duomenų rinkinys struktūros apraše nurodomas tam, kad būtų galimybė susieti
duomenų struktūros elementus su duomenų rinkiniais registruotais duomenų
kataloge. Toks susiejimas atliekamas naudojant duomenų rinkinio kodinį
pavadinimą.

.. note::

    Nurodytas duomenų rinkinio ar vardų erdvės kodinis pavadinimas turi būti
    unikalus tarp visų duomenų struktūros aprašų.

.. seealso::

    | :ref:`ns`
    | :ref:`kodiniai-pavadinimai`

.. data:: id

    Duomenų rinkinio arba duomenų erdvės identifikatorius.

.. data:: type

    Jei nenurodyta, pagal nutylėjimą naudojama `dataset` reikšmė, kuri nurodo
    duomenų rinkinio kodinį pavadinimą nurodyta :term:`duomenų kataloge
    <duomenų katalogas>`.

    Galimos reikšmės:

    ns
        Vardų erdvė.

    dataset
        Duomenų rinkinys.

    .. admonition:: Pavyzdys

        ======= ======== ===== ============= ==== ================ 
        dataset resource model property      type title           
        ======= ======== ===== ============= ==== ================ 
        datasets/gov/rc                      ns   Registrų centras
        ------------------------------------ ---- ---------------- 
        datasets/gov/rc/ar                   ns   Adresų registras
        ------------------------------------ ---- ---------------- 
        datasets/gov/rc/ar/ws                     Duomenų teikimo paslauga
        ==================================== ==== ================ 

.. data:: ref

    Duomenų rinkinio identifikatorius duomenų kataloge. Alternatyviai, galima
    naudoti :data:`dataset.source`.

    Nenaudojamas jei :data:`dataset.type` yra `ns`.

.. data:: source

    Nuoroda į duomenų rinkinio puslaptį duomenų kataloge.

    Nenaudojama, jei `dataset.type` yra `ns`.

.. data:: prepare

    Nenaudojama.

.. data:: level

    Nenaudojamas.

    Duomenų rinkinio brandos lygis yra išskaičiuojamas iš :data:`model.level`
    ir :data:`property.level`.

.. data:: access

    Prieigos lygis, naudojamas pagal nutylėjimą viesiems šios vardų erdvės
    elementams.

.. data:: title

    Duomenų rinkinio ar vardų erdvės pavadinimas.

.. data:: description

    Duomenų rinkinio ar vardų erdvės aprašymas.

.. .. _duomenų-šaltinis:
.. _resource:

resource
--------

.. module:: resource

Fizinis duomenų šaltinis, kuriame saugomi duomenys.

Kiekvienam duomenų šaltiniui suteikiamas :ref:`kodinis pavadinimas <kodiniai
pavadinimai>`, kuris nėra naudojamas formuojant API URI, tačiau naudojamas
identifikuojant patį duomenų šaltinį.

Nurodytas duomenų šaltinio kodinis pavadinimas turi būti unikalus duomenų
rinkinio kontekste.

.. seealso::

    :ref:`resource`

.. data:: id

    Duomenų šaltinio unikalus identifikatorius UUID formatu.

.. data:: type

    Duomenų šaltinio tipas. Galimos reikšmės:

    ========= ============================
    `sql`     Reliacinės duomenų bazės
    `csv`     CSV lentelės
    `json`    JSON resursai
    `xml`     XML resursai
    ========= ============================

.. data:: ref

    Identifikatorius, naudojamas konfiguracijoje, kurioje pateikiama pilnas
    resurso adresas ir kiti parametrai, tokie kaip slaptažodžiai ar
    prisijungimo vardai.

    Alternatyviai resurso pilną adresą galima nurodyti :data:`resource.source`
    stulpelyje.

.. data:: source

    Pilnas resurso adresas URI formatu.

    .. warning::

        Jei duomenų šaltinis reikalauja naudotojo vardo ir slaptažodžio,
        rekomenduojama nerodyti URI struktūros apraše, vietoj to prisijungimo
        duomenis prie šaltinio pateikti atskirame konfigūraciniame faile,
        naudojant :data:`resource.ref` stulpelį.

    **dialect** [ `+` **driver** ] `://` [ **user** `:` **password** `@` ]
    **host** [ `:` **port** ] `/` **path** [ `?` **params** ]

    dialect
        Duomenų šaltinio dialektas arba protokolas, kuriuo teikiami duomenys,
        galimi variantai:

        ================ ===========================
        `postgresql`     PostgreSQL duomenų bazė.
        `mysql`          MySQL duomenų bazė.
        `mariadb`        MariaDB duomenų bazė.
        `sqlite`         SQLite duomenų bazė.
        `oracle`         Oracle duomenų bazė.
        `mssql`          Microsoft SQL Server duomenų bazė.
        `http`, `https`  Duomenų failas publikuojamas HTTP protokolu.
        ================ ===========================

    driver
        Priklauso nuo **dialect** ir nuo naudojamo duomenų agento.

    user
        Duomenų šaltinio naudotojo vardas, jei duomenų šaltinis to reikalauja.

    password
        Duomenų šaltinio slaptažodis, jei duomenų šaltinis to reikalauja.

    host
        Duomenų šaltinio serverio adresas, jei duomenų šaltinis yra
        nuotoliniame serveryje.

    port
        Nuotolinio serverio prievado numeris.

    path
        Duomenų bazės pavadinimas arba kelias iki duomenų failo.

    params
        Papildomi parametrai, priklauso nuo naudojamo **driver**.


.. data:: level

    Duomenų šaltinio brandos lygis, vertinant tik pagal formatą, nežiūrint į
    šaltinyje esančių duomenų turinį.

.. data:: access

    Viso duomenų šaltinio prieigos lygis. Paveldimas.

.. data:: title

    Duomenų šaltinio pavadinimas.

.. data:: description

    Duomenų šaltinio aprašymas.

Duomenų šaltinio :data:`resource.type` reikšmė apibrėžia kokią :term:`ETL`
priemonę naudoti skaitant duomenis iš duomenų šaltinio. Automatizuota duomenų
priemonė skirta įstaigos duomenų atvėrimui turėtų palaikyti tik tokius duomenų
šaltinius, kurie naudojami įstaigos vidinėje infrastruktūroje.

Esant poreikiui gali būti įgyvendintas palaikymas naujiems duomenų šaltiniams.


.. _base:

base
----

.. module:: base

.. deprecated:: 0.2

   Atskira modelio bazė naikinama. Nuo 0.2 versijos, modelio bazė nurodoma
   :data:`model.type` stulpelyje.

Modelio bazė naudojama kelių modelių (lentelių) susiejimui arba apjungimui.
Kadangi įvairiuose duomenų šaltiniuose dažnai pasitaiko duomenų, kuriuose
saugomos tą pačią semantinę prasmę turinčios lentelės, :data:`base` stulpelyje
galima nurodyti kaip skirtingos lentelės siejasi tarpusavyje.

:data:`base.type` stulpelyje nurodoma kokiu būdu lentelės yra susiję.
:term:`ETL` priemonė vadovaujantis :data:`base` informacija duomenis
automatiškai transformuoja ir sujungia kelias lenteles į vieną.

Modeliai ne tik susiejami semantiškai tarpusavyje, bet taip pat suliejami ir
dviejų modelių duomenys naudojant laukų sąrašą nurodytą :data:`base.ref`
stulpelyje. :data:`base.ref` stulpelyje nurodyti laukai naudojami norint
unikaliai identifikuoti :data:`model` lentelėje esančią eilutę, kuri atitinka
:data:`base` lentelėje esančią eilutę. Tai reiškia, kad modelis ir jo bazė turi
vienodus identifikatorius.

Siejant :data:`model` ir :data:`base` duomenis tarpusavyje, :data:`model`
lentelė įgauna lygiai tokius pačius unikalius identifikatorius, kurie yra base
lentelėje. Tai reiškia, kad :data:`model` lentelėje negali būti duomenų, kurių
nėra :data:`base` lentelėje.

:data:`model.property` laukams, kurie sutampa su :data:`base` modelio laukais,
nenurodomas :data:`property.type`, tokiu būdu nurodoma, kad
:data:`model.property` turi tą pačią semantinę prasmę, kaip ir :data:`base`,
tačiau :data:`model` gali turėti ir papildomų laukų, kurių nėra :data:`base`
modelyje, tokiu atveju :data:`property.type` turi būti nurodomas.

Visi :data:`base.ref` laukai turi būti aprašyti tiek :data:`base`, tiek
:data:`model` modeliuose, tai reiškia, kad :data:`base.ref` gali būti naudojami
tik tiek laukai, kurie neturi tipo.

Jei :data:`base` stulpelyje nurodoma `/` reikšmė, tai reiškia, kad
:data:`model` neturi bazės, arba modelio bazė yra panaikinama. `/` naudojamas
tais atvejais, kai norima vieną ar kelis modelius prijungti prie vienos bazės,
tačiau sekantys modeliai nebeturi priklausyti jokiai bazei.

**Sinonimai**

Tais atvejais, kai visi :data:`model` laukai neturi :data:`property.type`, tada
toks modelis laikomas :data:`base` sinonimu ir iš esmės saugomas tik
identifikatorius.

Tačiau, jei bent vienas :data:`property.type` yra nurodytas, tada modelis įgyja
fizinę reprezentaciją ir turi vieną ar kelis savo laukus, kurių nėra
:data:`base` modelyje.

Kiekvieną kartą saugant duomenis per kitą modelį į bazę, bazės modelio
istorijoje išsaugoma informacija iš kokio modelio atėjo duomenys.

**Paveldimumas**

:data:`model` paveldi visus laukus, įskaitant ir tuos, kurie nėra nurodyti prie
:data:`model` laukų sąrašo. Tai reiškia, kad galima skaityti ir rašyti duomenis
į :data:`base`, per :data:`model`. Jei skaitomas ar rašomas laukas, kurio nėra
:data:`model` laukų sąraše, tada to lauko duomenys sakomi iš arba rašomi į
:data:`base` modelį.

Visi modelio laukai, kurie neturi tipo, fiziškai yra priskiriami :data:`base`
modeliui.

**Dubliavimas**

Laukai pavadinimai modelyje, kurie turi tą pačią semantinę prasmę, kaip ir
bazėje turi sutapti su pavadinimais nurodytais bazėje. Tačiau, jei yra
nurodomas jų tipas, tada tie duomenys dubliuojami, laikant, kad duomenys
skiriasi nuo bazės, nepaisant to, kad semantiškai jie yra vienodi.

Turint tokius dubliuojamus laukus su nurodytais tipais, jei norima pasiekti
bazės lauką, galima naudoti `_base.prop` išraišką, kuri nurodo, kad norima
pasiekti bazėje esančius duomenis, laukui tuo pačiu pavadinimu.


.. data:: source

    Nenaudojamas.

.. data:: prepare

    Išimtiniais atvejais, kai nėra galimybės lentelių susieti ar apjungti
    įprastiniais metodais, galima pasitelkti formules, kurių pagalba galima
    įgyvendinti nestandartinius lentelių apjungimo atvejus.

.. data:: type

    Nenaudojamas.

.. data:: ref

    :data:`model.property` reikšmė, kurios pagalba :data:`model` objektai
    siejami su :data:`base` objektais. Jei susiejimas pagal vieną model property
    yra neįmanomas, galima nurodyti kelis :data:`model.property` pavadinimus
    atskirtus kableliu.

    Galima naudoti tik tuos :data:`model.property`, kurie neturi nurodyto
    :data:`property.type`, kas reiškia, kad toks pat laukas turi būti tiek
    :data:`base`, tiek :data:`model` laukų sąraše.

    Tais atvejais, kai :data:`base.ref` rodo į modelio lauką, kuris turi tipą,
    tada :data:`base.level` negali būti didesnis nei `3`, kadangi jei modelio
    laukas turi tipą, tai reiškia, kad jo duomenys nesutampa su bazės
    duomenimis ir todėl jungimas negali būti daromas.

.. data:: level

    :ref:`Brandos lygis <level>`, nurodantis modelio susiejamumą su nurodytu
    baziniu modeliu. Plačiau žiūrėti :ref:`Ryšiai tarp modelių | Brandos lygis
    <ref-level>`.

    Jei brandos lygis yra žemesnis nei `3`, tada identifikatorių siejimas nėra
    atliekamas, tokiu būdu tiesiog nurodomas semantinis susiejimas metaduomenų,
    o ne duomenų lygmenyje.

.. data:: access

    Nenaudojamas.

Paaiškinimas, ką reiškia kiekviena savybė.

Pavyzdys be išorinio duomenų šaltinio:

== == == == =========== ========= ==========
d  r  b  m  property    type      ref       
== == == == =========== ========= ==========
example                                     
----------------------- --------- ----------
\        Location
-- -- -- -------------- --------- ----------
\           name\@lt    text                
\           population  integer             
\      Location
-- -- ----------------- --------- ----------
\        City
-- -- -- -------------- --------- ----------
\           name\@lt                        
\           population
\        Village
-- -- -- -------------- --------- ----------
\           name\@lt                        
\           population
\           region      ref       Location
\     /                                     
-- -- ----------------- --------- ----------
\        Country
-- -- -- -------------- --------- ----------
\           name\@lt                        
\           population
== == == == =========== ========= ==========

Šiame pavyzdyje:

- `City` ir `Village` priklauso vienai bazei `Location`.

- Kadangi `Location` turi savybes `name@lt` ir `population`, tai `City` ir
  `Village` modeliuose tą pačią semantinę prasmę turinčios savybės turi turėti
  lygiai tokius pačius pavadinimus, o :data:`property.type` turi būti tuščias.
  Kai :data:`property.type` yra tuščias, tai reiškia, kad savybė ateina iš
  bazinio modelio.

- Kadangi `Village` turi papildomą :data:`property` su nurodytu
  :data:`property.type`, tai reiškia, kad `name` ir population` priklauso
  bazei, tačiau `region` priklauso `Village` modeliui ir jo nėra bazėje.

- Kadangi `Country` semantiškai nėra tas pats, kas `Gyvenviete`, nors ir turi
  tokias pačias savybes, atskiriame ją nuo `Location` bazės, priskirdami `/`
  bazei, kas reiškia, kas bazės nėra.


Pavyzdys su išoriniu duomenų šaltiniu:

== == == == =========== ========= ========= ==================
d  r  b  m  property    type      ref       source
== == == == =========== ========= ========= ==================
example                                                       
----------------------- --------- --------- ------------------
\        Location                 id       
-- -- -- -------------- --------- --------- ------------------
\           id          integer
\           name\@lt    text
\           population  integer
\     Location                    name\@lt 
-- -- ----------------- --------- --------- ------------------
\        City                     name\@lt  CITY
-- -- -- -------------- --------- --------- ------------------
\           name\@lt                        NAME
\           population                      POPULATION
\        Village                  name\@lt  VILLAGE
-- -- -- -------------- --------- --------- ------------------
\           name\@lt                        VILLAGE
\           population                      POPULATION
\           region      ref       Location  REGION
== == == == =========== ========= ========= ==================

Šiame pavyzdyje esminis skirtumas yra tas, kad nurodyta kaip daromas jungimas.
`City` ir `Village` su `Location` jungiame per `name\@lt` lauką.


.. .. _duomenų-modelis:
.. _model:

model
-----

.. module:: model

Duomenų modelis apibrėžia duomenų grupę turinčią tas pačias savybes.
Skirtinguose duomenų šaltiniuose ir formatuose, duomenų modelis gali būti
išreikštas skirtingomis formomis, pavyzdžiui `sql` duomenų šaltinio atveju,
modelis aprašo vieną duomenų bazės lentelę.

Kiekvienas modelis turi turėti pirminį raktą, unikalų modelio duomenų
identifikatorių. Pirminis raktas aprašomas pateikiant vieną ar kelias
:data:`model.property` reikšmes :data:`model.ref` stulpelyje, kurios kartu
unikaliai identifikuoja kiekvieną duomenų eilutę.

Išimtiniais atvejais, kai modelio duomenų laukų reikšmės turi būti generuojamos
dinamiškai ar kitais nestandartiniais atvejais yra galimybė nurodyti model.type
reikšmę. Jei :data:`model.type` yra pateiktas, tada už modelio duomenų
generavimą, įeinančių duomenų tikrinimą ir visos kitos su modeliu susijusios
dalys gali būti pritaikytos konkretaus modelio atvejui. Tačiau, jei reikia
keisti tik duomenų pateikimą, užtenka naudoti :data:`model.prepare` formules.

.. data:: source

    Modelio pavadinimas šaltinyje. Prasmė priklauso nuo :data:`resource.type`.

.. data:: prepare

    Formulė skirta duomenų filtravimui ir paruošimui, iš dalies priklauso nuo
    :data:`resource.type`.

    Taip pat skaitykite: :ref:`duomenų-atranka`.

.. data:: type

    .. versionchanged:: 0.2

        Nuo 0.2 versijos nurodo modelio bazę.

    Nurodo modelio bazę, tai reiškia, kad tiek šis modelis, tiek bazinis
    modelis turi vienodus identifikatorius.

    Jei nurodyta modelio bazė, :data:`model.ref` nurodytas pirminis raktas turi
    sutaptu su bazinio modelio pirminiu raktu.

.. data:: ref

    Kableliu atskirtas sąrašas :data:`model.property` reikšmių, kurios kartu
    unikaliai identifikuoja vieną duomenų eilutę (pirminis lentelės raktas).

.. data:: level

    Modelio :ref:`brandos lygis <level>`, nusakantis pačio modelio brandos
    lygį, pavyzdžiui ar nurodytas pirminis raktas, ar modelio pavadinimas
    atitinka kodiniams pavadinimams kelimus reikalavimus.

.. data:: access

    Modeliui priklausančių laukų :ref:`prieigos lygis <access>`. Paveldimas.

.. data:: uri

    Sąsaja su :ref:`išoriniu žodynu <vocab>`.

.. data:: title

    Modelio pavadinimas.

.. data:: description

    Modelio aprašymas.

.. data:: property

    Modeliui priklausantis duomenų laukas.


.. .. _savybė:
.. _property:

property
--------

.. module:: property


Duomenų laukas atspindi tam tikrą modelio savybę arba tai gali būti lentelės
stulpelis, jei duomenų šaltinis yra lentelė.

.. data:: source

    Duomenų lauko pavadinimas šaltinyje. Prasmė priklauso nuo
    :data:`resource.type`.

.. data:: prepare

    Formulė skirta duomenų tikrinimui ir transformavimui arba statinės reikšmės
    pateikimui.

.. data:: type

    Nurodomas loginis duomenų tipas. Dėl galimų tipų sąrašo žiūrėti
    :ref:`duomenų-tipai`.

    Loginis duomenų tipas yra toks tipas, kurį tikitės gauti publikuojant
    duomenis per API. Loginis tipas gali skirtis nuo duomenų šaltinio tipo.

    Visi duomenų tipai gali turėti tokius parametrus:

    - `required` - nurodo, kad šis duomenų laukas yra privalomas, tai reiškia,
      kad šio duomenų lauko reikšmė visada turi būti pateikta. Pagal nutylėjimą
      visi modelio duomenų laukai yra neprivalomi.

    Kai kurie duomenų tipai, gali turėti konkrečiam duomenų tipui pateikiamus
    papildomus parametrus, tokie parametrai nurodomi skliausteliuose.

    Dupmenų tipų pavyzdžiai:

    - `integer`

    - `integer required`

    - `geometry`

    - `geometry(linestringm, 3345) required`

.. data:: ref

    Priklauso nuo `property.type`, nurodo matavimo vienetus, laiko ar vietos
    tikslumą, :ref:`klasifikatorių <enum>` arba :ref:`ryšį su kitais modeliais
    <ryšiai>`. Ką tiksliai reiškia šis laukas, patikslinta skyrelyje
    :ref:`duomenų-tipai`.

.. data:: level

    Nurodo duomenų lauko brandos lygį. Žiūrėti :ref:`level`.

.. data:: access

    Nurodo prieigos prie duomenų lygį. Žiūrėti skyrių :ref:`access`.

.. data:: uri

    Sąsaja su išoriniu žodynu. Žiūrėti :ref:`vocab`.

.. data:: title

    Duomenų lauko pavadinimas. Šis pavadinimas yra skirtas skaityti žmonėms
    ir bus rodomas duomenų laukų sąrašuose ir antraštėse. Jei nenurodyta, bus
    naudojamas :data:`property` kodinis pavadinimas.

.. data:: description

    Duomenų lauko aprašymas.

.. data:: enum

    Žiūrėti :ref:`enum`.


.. _papildomos-dimensijos:

Papildomos dimensijos
=====================

.. .. _išorinių-žodynų-prefiksai:
.. _prefix:

prefix
------

.. module:: prefix

Sąsają su išoriniais žodynais galima pateikti :data:`model.uri` ir
:data:`property.uri` stulpeliuose. Tačiau prieš naudojant žodynus, pirmiausia
reikia apsirašyti žodynų prefiksus. Žodynų prefiksai aprašomi taip:


.. data:: ref

    Prefikso pavadinimas.

.. data:: uri

    Išorinio žodyno URI.

.. data:: title

    Prefikso antraštė.

.. data:: description

    Prefikso aprašymas.

Rekomenduojama naudoti LOV_ prefiksus.

.. _LOV: https://lov.linkeddata.es/dataset/lov/

Aprašyti prefiksai gali būti naudojami :data:`model.uri` ir :data:`property.uri`
stulpeliuose tokiu būdu: `prefix:name`.

Pavyzdys:

== == == == ============ ======== ========= ====================================================
d  r  b  m  property     type     ref       uri                                                 
== == == == ============ ======== ========= ====================================================
dataset1                                                                                        
------------------------ -------- --------- ----------------------------------------------------
\                        prefix   spinta    \https://github.com/atviriduomenys/manifest/issues/
\                                 manifest  \https://github.com/atviriduomenys/spinta/issues/
\                                 vadovas   \https://atviriduomenys.readthedocs.io/
\                                 dct       \http://purl.org/dc/dcmitype/
dataset2                                                                                        
------------------------ -------- --------- ----------------------------------------------------
\                        prefix   dcat      \http://www.w3.org/ns/dcat#
\                                 dct       \http://purl.org/dc/terms/
\                                 dctype    \http://purl.org/dc/dcmitype/
\                                 foaf      \http://xmlns.com/foaf/0.1/
\                                 owl       \http://www.w3.org/2002/07/owl#
\                                 prov      \http://www.w3.org/ns/prov#
\                                 rdf       \http://www.w3.org/1999/02/22-rdf-syntax-ns#
\                                 rdfs      \http://www.w3.org/2000/01/rdf-schema#
\                                 sdo       \http://schema.org/
\                                 skos      \http://www.w3.org/2004/02/skos/core#
\                                 vcard     \http://www.w3.org/2006/vcard/ns#
\                                 xsd       \http://www.w3.org/2001/XMLSchema#
== == == == ============ ======== ========= ====================================================

Prefiksai turi būti apibrėžti duomenų rinkinio kontekste, kadangi skirtingi
duomenų rinkiniai gali naudoti skirtingus prefiksus, tiems pateims URI.
Pavyzdžiui abiejusoe rinkinyje pavyzdyje aukščiau, `dct` ir `dctype` rodo į tą
patį URI.


.. _enum:

enum
----

.. module:: enum

.. _Categorical data: https://pandas.pydata.org/pandas-docs/stable/user_guide/categorical.html

Tam tikri duomenų laukai turi fiksuotą reikšmių variantų aibę. Dažnai duomenų
bazėse fiksuotos reikšmės saugomos skaitine forma ar kitais kodiniais
pavadinimais. Tokias fiksuotas reikšmes duomenų struktūros apraše galima
pateikti neužpildant hierarchinių stulpelių ir nurodant `type` reikšmę
`enum`, pavyzdžiui:

+----+---+---+---+---+----------+---------+-----+-----------+-----------+-------+--------+-----+---------+-------------+
| id | d | r | b | m | property | type    | ref | source    | prepare   | level | access | uri | title   | description |
+====+===+===+===+===+==========+=========+=====+===========+===========+=======+========+=====+=========+=============+
|  1 | datasets/example/places  |         |     |           |           |       |        |     |         |             |
+----+---+---+---+---+----------+---------+-----+-----------+-----------+-------+--------+-----+---------+-------------+
|  2 |   | places               | sql     |     | sqlite:// |           |       |        |     |         |             |
+----+---+---+---+---+----------+---------+-----+-----------+-----------+-------+--------+-----+---------+-------------+
|  3 |   |   |   | Place        |         | id  | PLACES    |           |       |        |     |         |             |
+----+---+---+---+---+----------+---------+-----+-----------+-----------+-------+--------+-----+---------+-------------+
|  4 |   |   |   |   | id       | integer |     | ID        |           | 3     | open   |     |         |             |
+----+---+---+---+---+----------+---------+-----+-----------+-----------+-------+--------+-----+---------+-------------+
|  5 |   |   |   |   | type     | string  |     | CODE      |           | 3     | open   |     |         |             |
+----+---+---+---+---+----------+---------+-----+-----------+-----------+-------+--------+-----+---------+-------------+
|  6 |   |   |   |   |          | enum    |     | 1         | "city"    |       |        |     | City    |             |
+----+---+---+---+---+----------+---------+-----+-----------+-----------+-------+--------+-----+---------+-------------+
|  7 |   |   |   |   |          |         |     | 2         | "town"    |       |        |     | Town    |             |
+----+---+---+---+---+----------+---------+-----+-----------+-----------+-------+--------+-----+---------+-------------+
|  8 |   |   |   |   |          |         |     | 3         | "village" |       |        |     | Village |             |
+----+---+---+---+---+----------+---------+-----+-----------+-----------+-------+--------+-----+---------+-------------+
|  9 |   |   |   |   | name     | string  |     | NAME      |           | 3     | open   |     |         |             |
+----+---+---+---+---+----------+---------+-----+-----------+-----------+-------+--------+-----+---------+-------------+

Šiame pavyzdyje `Place.type` laukas yra klasifikatorius, kurio reikšmės yra
kodai 1, 2 ir 3, kurios duomenų struktūros apraše keičiamos į `city`, `town`
ir `village`, papildomai `title` stulpelyje nurodant reikšmės pavadinimą.

Jei tas pats klasifikatorius gali būti naudojamas kelios skirtingose vietos,
tada galima iškelti klasifikatorių ir suteikti jam pavadinimą, pavyzdžiui:

+----+---+---+---+---+----------+---------+---------+-----------+---------------+-------+--------+-----+---------+-------------+
| id | d | r | b | m | property | type    | ref     | source    | prepare       | level | access | uri | title   | description |
+====+===+===+===+===+==========+=========+=========+===========+===============+=======+========+=====+=========+=============+
|  1 | datasets/example/places  |         |         |           |               |       |        |     |         |             |
+----+---+---+---+---+----------+---------+---------+-----------+---------------+-------+--------+-----+---------+-------------+
|  6 |   |   |   |   |          | enum    | place   | 1         | "city"        |       |        |     | City    |             |
+----+---+---+---+---+----------+---------+---------+-----------+---------------+-------+--------+-----+---------+-------------+
|  7 |   |   |   |   |          |         |         | 2         | "town"        |       |        |     | Town    |             |
+----+---+---+---+---+----------+---------+---------+-----------+---------------+-------+--------+-----+---------+-------------+
|  8 |   |   |   |   |          |         |         | 3         | "village"     |       |        |     | Village |             |
+----+---+---+---+---+----------+---------+---------+-----------+---------------+-------+--------+-----+---------+-------------+
|  2 |   | places               | sql     |         | sqlite:// |               |       |        |     |         |             |
+----+---+---+---+---+----------+---------+---------+-----------+---------------+-------+--------+-----+---------+-------------+
|  3 |   |   |   | Place        |         | id      | PLACES    |               |       |        |     |         |             |
+----+---+---+---+---+----------+---------+---------+-----------+---------------+-------+--------+-----+---------+-------------+
|  4 |   |   |   |   | id       | integer |         | ID        |               | 3     | open   |     |         |             |
+----+---+---+---+---+----------+---------+---------+-----------+---------------+-------+--------+-----+---------+-------------+
|  5 |   |   |   |   | type     | string  | place   | CODE      |               | 3     | open   |     |         |             |
+----+---+---+---+---+----------+---------+---------+-----------+---------------+-------+--------+-----+---------+-------------+
|  9 |   |   |   |   | name     | string  |         | NAME      |               | 3     | open   |     |         |             |
+----+---+---+---+---+----------+---------+---------+-----------+---------------+-------+--------+-----+---------+-------------+

Šiuo atveju, klasifikatoriui buvo suteiktas pavadinimas `place` įrašytas
`enum.ref` stulpelyje, 6 eilutėje. O `Place.type` laukui, `prepare`
stulpelyje nurodyta, kad šis laukas naudoja vardinį `place` klasifikatorių.


.. data:: ref

    Pasirinkimų sąrašo pavadinimas.

.. data:: source

    Pateikiama originali reikšmė, taip kaip ji saugoma duomenų šaltinyje.
    Pateiktos reikšmės turi būti unikalios ir negali kartotis.

    Jei pageidaujama aprašyti tuščią šaltinio reikšmę, tada
    :data:`property.prepare` celėje reikia nurodyti formulę, kuri tuščią
    reikšmę pakeičia, į kokią nors kitą. Formulės pavyzdys:

    .. code-block:: python

        swap('', '-')

.. data:: prepare

    Pateikiama reikšmė, tokia kuri bus naudojama atveriant duomenis.
    :data:`model.prepare` filtruose taip pat bus naudojama būtent ši
    reikšmė.

    `enum.prepare` reikšmės gali kartotis, tokiu būdu, kelios skirtingos
    `enum.source` reikšmės bus susietos su viena `enum.prepare` reikšme.

.. data:: access

    Klasifikatoriams galima nurodyti skirtingas prieigos teises, tokiu
    atveju, naudotojas turintis `open` prieigą matys tik tuos duomenis,
    kurių klasifikatorių reikšmės turi `open` prieigos teises, visi kiti bus
    išfiltruoti.

.. data:: title

    Fiksuotos reikšmės pavadinimas.

.. data:: description

    Fiksuotos reikšmės aprašymas.

Pagal nutylėjimą, jei :data:`property.prepare` yra tuščias ir :data:`property`
turi :ref:`enum` sąrašą, tada jei šaltinis turi neaprašytą reikšmę, turėtų
būti fiksuojama klaida.

Jei yra poreikis fiksuoti tik tam tikras reikšmes, o visas kitas palikti tokias,
kokios yra šaltinyje, tada :data:`property.prepare` stulpelyje reikia įrašyti
`self.choose(self)`.


.. _param:

param
-----

.. module:: param

.. deprecated:: 0.2

    Nuo 0.2 versijos parametrų dimensija perkeliama prie :ref:`property` ir
    tampa duomenų tipo parametras.


Parametrai leidžia iškelti tam tikras duomenų paruošimo operacijas į parametrus
kurie gali būti naudojami :ref:`dimensijos`, kurioje apibrėžtas parametras
kontekste. Parametrai gali gražinti :term:`iteratorius`, kurių pagalba galima
dinamiškai kartoti :data:`resource` duomenų skaitymą, panaudojant aprašytus
parametrus. Taip pat parametrų pagalba galima sudaryti reikšmių sąrašus, kurių
pagalba galima kartoti :data:`resource` su kiekviena reikšme.

Parametrai dažniausiai naudojami žemesnio brandos lygio duomenų šaltiniams
aprašyti, o taip pat API atvejais, kai duomenys atiduodame dinamiškai.

Parametrai aprašomi pasitelkiant papildomą :ref:`param` dimensiją.

+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
| id | d | r | b | m | property   | type    | ref                   | source                      | prepare               |
+====+===+===+===+===+============+=========+=======================+=============================+=======================+
|  1 | datasets/example/cities    |         |                       |                             |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  2 |   | places                 | csv     |                       | \https://example.com/{}.csv |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  3 |   |   |   | Country        |         | id                    | countries                   |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  4 |   |   |   |   | code       | string  |                       | CODE                        |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  5 |   |   |   |   | title      | string  |                       | TITLE                       |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  6 |   |   |   | City           |         | country, |nbsp| title | cities/{country.code}       |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  7 |   |   |   |   |            | param   | country               | Country                     | select(code)          |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  8 |   |   |   |   | country    | ref     | Country               |                             | param("country").code |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  9 |   |   |   |   | title      | string  |                       | TITLE                       |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+

.. data:: ref

    Parametro :term:`kodinis pavadinimas`.

.. data:: prepare

    Formulė, kuri grąžina sąrašą reikšmių aprašomam parametrui.

.. data:: source

    Jei reikšmė pateikta, tada ši reikšmė perduodama formulei kaip `self`.
    Pavyzdžiui, jei :data:`param.prepare` pateikta formulė `select(code)`, o
    :data:`param.source` nurodyta `Country`, tai formulė bus iškviesta taip
    `select("Country", code)`.

Jei parametro reikšmė yra :term:`iteratorius`, tada :term:`dimensija`, kurios
kontekste yra aprašytas :ref:`parametras <param>` yra kartojama tiek kartų,
kiek reikšmių grąžina :term:`iteratorius`.

Jei yra keli :ref:`param` grąžinantys :term:`iteratorius`, tada iš
visų :term:`iteratorių <iteratorius>` sudaroma `Dekarto sandauga`_ ir
:data:`resource` dimensija vykdoma su kiekviena sandaugos rezultato reikšme.

.. _Dekarto sandauga: https://lt.wikipedia.org/wiki/Dekarto_sandauga

Jei sekančioje :term:`DSA` eilutėje, einančioje po eilutės, kurioje aprašytas
:ref:`param`, nenurodytas :data:`type` ir neužpildytas joks kitas
:term:`dimensijos <dimensija>` stulpelis, tada parametras tampa
:term:`iteratoriumi <iteratorius>`, kurio reikšmių sąrašą sudaro sekančiose
eilutėse patektos :data:`source` ir :data:`prepare` reikšmės. Pavyzdžiui
anksčiau pateiktą pavyzdį galima būtų perdaryti taip:

+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
| id | d | r | b | m | property   | type    | ref                   | source                      | prepare               |
+====+===+===+===+===+============+=========+=======================+=============================+=======================+
|  1 | datasets/example/cities    |         |                       |                             |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  2 |   | places                 | csv     |                       | \https://example.com/{}.csv |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  3 |   |   |   | Country        |         | id                    | countries                   |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  4 |   |   |   |   | code       | string  |                       | CODE                        |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  5 |   |   |   |   | title      | string  |                       | TITLE                       |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  6 |   |   |   | City           |         | country, |nbsp| title | cities/{country}            |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  7 |   |   |   |   |            | param   | country               |                             | "lt"                  |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  7 |   |   |   |   |            |         |                       |                             | "lv"                  |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  7 |   |   |   |   |            |         |                       |                             | "ee"                  |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  8 |   |   |   |   | country    | ref     | Country               |                             | param("country")      |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+
|  9 |   |   |   |   | title      | string  |                       | TITLE                       |                       |
+----+---+---+---+---+------------+---------+-----------------------+-----------------------------+-----------------------+

Šiame pavyzdyje, parametras `country` grąžins tris šalies kodus: lt, lv ir
ee, kurie bus panaudojami `cities/{country}` pavadinime, pakeičiant
`{country}` dalį.

:ref:`param` reikšmės pasiekiamos naudojanti pavadinimą įrašytą
:data:`param.ref` stulpelyje. Pavyzdžiui, jei :data:`param.ref` stulpelyje
įrašyta `x`, tada `x` parametro reikšmę galima gauti taip:

.. describe:: source

    `{x}`.

.. describe:: prepare

    `x` arba `param(x)`.

Parametrų generavimui galima naudoti tokias formules:

.. describe:: param.prepare

    .. function:: range(stop)

        Sveikų skaičių generavimas nuo 0 iki `stop`, `stop` neįeina.

    .. function:: range(start, stop)
       :noindex:

        Sveikų skaičių generavimas nuo `start` iki `stop`, `stop` neįeina.

    .. function:: scalar(name)

        Jei nurodytas :data:`param.source`, tada imama tik `name` lauko reikšmė,
        o ne visi modelio laukai.

Jei užpildytas :data:`param.source` stulpelis, tada :data:`param.prepare`
stulpelyje galima naudoti filtrą nurodyto :data:`param.source` modelio duomenims
filtruoti, o naudojant parametrus galima nurodyti ir modelio laukų pavadinimus,
pavyzdžiui:

.. describe:: source

    `{x.field}`.

.. describe:: prepare

    `x.field` arba `param(x).field`.


.. _switch:

switch
------

.. module:: switch

Tam tikrais atvejais duomenis tenka normalizuoti parenkant tam tikrą reikšmę jei
tenkinama nurodyta sąlyga. Tokias situacijas galima aprašyti pasitelkiant
:data:`switch` dimensiją.

.. data:: switch.source

    Reikšmė, kuri bus atveriama.

.. data:: switch.prepare

    Sąlyga, naudojant einamojo modelio laukus. Jei sąlyga tenkinama, tada
    laukui priskiriama :data:`switch.source` reikšmė. Jei sąlyga
    netenkinama, tada bandoma tikrinti sekančią sąlygą. Parenkama ta
    reikšmė, kurios pirmoji sąlyga tenkinama.

    Jei :data:`switch.prepare` yra tuščias, tada sąlyga visada teigiama ir
    visada grąžinama :data:`switch.source` reikšmė.


.. _comment:

comment
-------

..module:: comment

Dirbant su :term:`DSA` yra galimybė komentuoti eilutes, naudojant papildomą
:data:`comment` dimensiją, kurią galima naudoti bet kurios kitos dimensijos
kontekste.


.. data:: id

    Komentaro numeris.

.. data:: ref

    Komentuojamo vieno ar kelių kableliu atskirtų :data:`property`
    pavadinimai. Galima nurodyti ne tik stulpelio pavadinimą, bet ir
    dimensiją.

.. data:: source

    Komentaro autorius.

.. data:: prepare

    Keitimo pasiūlymas, naudojant `create()`, `update` ir `delete()` funkcijas. Pavyzdžiui::

        update(property: "pavadinimas@lt", type: "text")

    Šiuo atveju nurodoma, kad siūloma keisti `property` pavadnimą į
    `pavadinimas@lt`, o `type` į `text`.

.. data:: level

    Nurodoma, kad patenkinus keitimo sliūlymą, kuris nurodytas
    :data:`comment.prepare` stulplyje, komentuojamai eilutei gali būti
    suteiktas nurodytas brandos lygis.

.. data:: access

    Nurodoma, ar komentaras gali būti publikuojamas viešai.

    private
        Komentaras negali būti publikuojamas viešai. Šis prieigos lygis
        naudojamas pagal nutylėjimą.

    open
        Komentaras gali būti publikuojamas viešai.

.. data:: uri

    Viena ar kelios kableliu atskirtos šaltinio nuorodos, kuri pateikta
    daugiau informacijos apie tai, kas komentuojama. Taip pat gali būti
    nurodytas kito komentaro :data:`comment.id`, nurodant, kad tai yra
    atsakymas į ankstesnį komentarą.

    URI pateikiami sutrumpinta forma, naudojant prefikstus. Žiūrėti skrių
    :ref:`vocab`.

.. data:: title

    Komentaro data, `ISO 8601`_ formatu.

    .. _ISO 8601: https://en.wikipedia.org/wiki/ISO_8601

.. data:: description

    Komentaro tekstas.


**Pavyzdys**


== == == == ============ ======== ========= ================================================== ====== ======= ====================================================
d  r  b  m  property     type     ref       prepare                                            level  access  uri                                                 
== == == == ============ ======== ========= ================================================== ====== ======= ====================================================
example                                                                                                                                                           
------------------------ -------- --------- -------------------------------------------------- ------ ------- ----------------------------------------------------
\                        prefix   spinta                                                                      \https://github.com/atviriduomenys/manifest/issues/
\                                 manifest                                                                    \https://github.com/atviriduomenys/spinta/issues/
\                                 vadovas                                                                     \https://atviriduomenys.readthedocs.io/
\        Imone                                                                                 2                           
-- -- -- --------------- -------- --------- -------------------------------------------------- ------ ------- ----------------------------------------------------
\                        comment  base      update(base: "/jar/JuridinisAsmuo", ref: "id")     4      open    spinta:205, manifest:1290                                                    
\                        comment  ref       update(ref: "id")                                  4      open    vadovas:dsa/dimensijos.html#model.ref                                                    
\           id           integer                                                               4      open                                                        
\           pavadinimas  string                                                                2      open                                                        
\                        comment  ref       update(property: "pavadinimas\@lt", type: "text")  4      open    spinta:204                                                    
== == == == ============ ======== ========= ================================================== ====== ======= ====================================================


.. _lang:

lang
----

.. module:: lang

.. deprecated:: 0.2


:data:`title` ir :data:`description` stulpeliuose tekstas rašomas lietuvių
kalba, tačiau galima pateikti tekstą ir kita kalba, panaudojus papildomą
:data:`lang` dimensiją, kurią reikia naudoti prieš eilutę, kuriai pateikiamas
tekstas kita kalba.

.. data:: ref

    `ISO 639-1`_ dviejų simbolių kalbos kodas.

    .. _ISO 639-1: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

.. data:: title

    Pavadinimas :data:`lang.ref` stulpelyje nurodyta kalba.

.. data:: description

    Aprašymas :data:`lang.ref` stulpelyje nurodyta kalba.


.. .. _struktūros-keitimas:
.. _migrate:

migrate
-------

.. module:: migrate

.. deprecated:: 0.2

Laikui einant, pirminių duomenų šaltinių arba jau atvertų duomenų struktūra
keičiasi, papildoma naujais :term:`modeliais <modelis>` ar :term:`savybėmis
<savybė>`, keliant duomenų brandos lygį seni duomenys keičiami naujais,
aukštesnio brandos lygio duomenimis.

Visi šie struktūros ar pačių duomenų pasikeitimai fiksuojami papildomos
:data:`migrate` dimensijos pagalba, kuri gali būti naudojama, bet kurios kitos
dimensijos kontekste.

.. note::
    Migracijos naudojamos tik tuo atveju, kai keičiasi duomenų struktūra arba
    patys duomenys. Jei keičiasi tik metaduomenys, tai migracijų sąraše
    neatsispindi.

== == == == == =============== ======== === ========================= ===== ============================= ===================
id d  r  b  m  property        type     ref prepare                   level title                         description
== == == == == =============== ======== === ========================= ===== ============================= ===================
1                              migrate                                      2021-12-21\ |nbsp|\ 16:29     Pirmoji migracija.
2                              migrate  1                                   2021-12-21\ |nbsp|\ 16:33     Antroji migracija.
3                              migrate  2                                   2022-06-21\ |nbsp|\ 16:41     Trečioji migracija.
\  datasets/example/migrate
-- --------------------------- -------- --- ------------------------- ----- ----------------------------- -------------------
\           Country                     id
-- -- -- -- ------------------ -------- --- ------------------------- ----- ----------------------------- -------------------
\              id              integer                                4
-- -- -- -- -- --------------- -------- --- ------------------------- ----- ----------------------------- -------------------
\              code            string                                 3
\                              migrate  1   create(level:\ |nbsp|\ 2)
\                              migrate  3   update(level:\ |nbsp|\ 3)
\              name            string
\                              migrate  2   create()
== == == == == =============== ======== === ========================= ===== ============================= ===================

Pavyzdyje aukščiau matome, kad šis duomenų struktūros aprašas turi tris
migracijas:

1. Pirmosios migracijos metu sukuriamas pradinis duomenų struktūros variantas.
   Pirmoji migracija nežymima prie modelių ir duomenų laukų, nebent daromas
   keitimas, tuomet įtraukiam ir pirmoji migracija, kad būtų matoma, kas
   keitėsi. Būtent toks atvejis parodytas prie `Country.code` lauko, kuri
   trečiojo migracijoje keičiamas brandos lygis.

2. Antrosios migracijos metu buvo įtrauktas naujas duomenų laukas
   `Country.name`.

3. Trečiosios migracijos metu, buvo keičiami `Country.code` lauko duomenys,
   pakeitimo metu brandos lygis buvo pakeltas iki trečio. Atkreipkite dėmesį,
   kad metaduomenų pasikeitimas, kaip šiuo atveju, žymimas migracijose tik tuo
   atveju, jei tai yra susiję su pačių duomenų pasikeitimu.

   Jei brandos lygis būtų pakeistas, nekeičiant pačių duomenų, tuomet tokio
   pakeitimo nereikėtų įtraukti į migracijų sąrašą.

   Kadangi trečiojoje migracijoje buvo atliktas su ankstesne versija
   nesuderinamas pakeitimas, tai šios migracijos data yra 6 mėnesiai
   ateityje, kadangi nesuderinamos migracijos pirmiausia paskelbiamos, o
   įgyvendinamos tik praėjus 6 mėnesiams nuo paskelbimo.

.. data:: id

    Migracijos numeris (UUID). Kiekvienos migracijos metu gali būti
    atliekama eilė operacijų, visos operacijos fiksuojamos naudojant
    migracijos numerį.

    Visų migracijų sąrašas pateikiamas, kai :data:`migrate` nepriklauso
    jokiam dimensijos kontekstui.

.. data:: ref

    Ankstesnės migracijos numeris, pateiktas :data:`migrate.id` stulpelyje,
    arba tuščia, jei prieš tai jokių kitų migracijų nebuvo.

    Naudojamas jei :data:`migrate` nepatenka į jokios dimensijos kontekstą.

    Jei :data:`migrate` aprašomas dimensijos kontekste, tada šis stulpelis
    nenaudojamas.

.. data:: prepare

    Migracijos operacija. Galimos tokios operacijos:

    .. function:: create()

        Priklausomai nuo dimensijos konteksto, prideda naują modelį, arba
        savybę.

        Funkcijai galima perduoti `ref` ir kitus vardinius argumentus,
        kurie atitinka :term:`DSA` lentelės metaduomenų stulpelių
        pavadinimus.

    .. function:: update()

        Taikomas tik duomenų laukams ir nurodo, kad buvo pakeistos esamų
        duomenų reikšmės, keičiant reikšmių dimensiją, matavimo vienetus,
        formatą ir kita.

        Funkcijai galima perduoti `ref` ir kitus vardinius argumentus,
        kurie atitinka :term:`DSA` lentelės metaduomenų stulpelių
        pavadinimus.

        Perduodami tik tie vardiniai argumentai, kuriuos atitinkantys
        metaduomenys keičiasi.

    .. function:: delete()

        Priklausomai nuo dimensijos konteksto, šalina modelį ar savybę.

        Pašalinto modelio ar savybės :data:`type` keičiamas į `absent`
        reikšmę.

    .. function:: filter(where)

        Naudojamas :data:`property` kontekste, kai vykdoma duomenų
        migracija. Nurodo, kad migracija taikoma tik `where` sąlygą
        tenkinantiems duomenims.

    Be šių pagrindinių migracijos operacijų, galima naudoti kitas duomenų
    transformavimo operacijas, kurios vykdomos su kiekviena duomenų eilute
    ir atlikus pateiktas transformacijos funkcijas, pakeista reikšmė
    išsaugoma.

.. data:: title

    Migracijos įvykdymo data ir laikas. Migracijos laikas ir data gali
    būti ir ateityje, tuo atveju, jei daromas nesuderinamas keitimas.

    Naudojamas tik tada, kai :data:`migrate` nepatenka į jokios dimensijos
    kontekstą.

.. data:: description

    Migracijos atliekamo pakeitimo trumpas aprašymas.


.. |nbsp| unicode:: 0xA0
   :trim:
