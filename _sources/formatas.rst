.. default-role:: literal

Lentelės formatas
#################

:term:`DSA` yra sudarytas taip, kad būtų patogu dirbti tiek žmonėms, tiek
programoms. Žmonės su :term:`DSA` lentele gali dirbti naudojantis, bet kuria
skaičiuoklės programa ar kitas pasirinktas priemones. Kadangi :term:`DSA` turi
aiškią ir griežtą struktūrą, lentelėje pateiktus duomenis taip pat gali lengvai
nuskaityti ir interpretuoti kompiuterinės programos.

Tais atvejais, kai su :term:`DSA` lentele dirba žmonės, lentelė gali būti
saugoma įstaigos pasirinktos skaičiuoklės programos ar kitų priemonių formatu.

Automatizuotoms priemonėms :term:`DSA` turi būti teikiamas CSV formatu laikantis
:rfc:`4180` taisyklių, failo koduotė turi būti UTF-8.

DSA lentelė gali būti importuojama į `Duomenų katalogą`_, kuriame DSA lentelės
turinys gali būti tvarkomas naudojantis grafine naudotojo sąsaja.

Rengiant duomenų struktūros aprašus darbas vyksta su viena lentele. Lentelės
stuleliai sudaryti iš dimensijų ir metaduomenų.

.. image:: /_static/struktura.png

Lentelė sudaryta hierarchiniu principu. Kiekvienas metaduomenų stulpelis gali
turėti skirtingą prasmę, priklausomai nuo dimensijos. Todėl toliau
dokumentacijoje konkrečios dimensijos stulpelis yra žymimas nurodant tiek
dimensijos, tiek metaduomenų pavadinimus, pavyzdžiui :data:`property.type`,
kuris nurodo :data:`type` metaduomenų stulpelį, esantį :data:`property`
dimensijoje.

.. _dimensijos-stulpeliai:

Dimensijos
**********

Duomenų struktūros aprašo lentelė sudaryta hierarchiniu principu. Kiekvienos
lentelės eilutės prasmę apibrėžia :ref:`dimensijos` stulpelis.

Kiekvienoje eilutėje gali būti užpildytas tik vienas dimensijos stulpelis.

Be šių penkių dimensijų, yra kelios :ref:`papildomos dimensijos
<papildomos-dimensijos>`, jos nurodomos :data:`type` stulpelyje, neužpildžius
nei vieno dimensijos stulpelio.

.. data:: dataset

    **Duomenų rinkinys**

    Kodinis duomenų rinkinio pavadinimas. Naudojant duomenų rinkinio kodinį
    pavadinimą formuojamas API.

    Duomenų rinkinio kodinis pavadinimas užrašomas pagal tokį šabloną:

    `datasets/` **forma** `/` **organizacija** `/` **katalogas** `/` **rinkinys**

    Visi duomenų rinkinio pavadinimo komponenta užrašomi mažosiomis raidėmis,
    jei reikia žodžiai atskiriami `_` simbolio pagalba.

    forma
        Nurodo organizacijos teisinę formą, galimi variantai:
        
        | **gov** - Viešasis sektorius.
        | **com** - Privatusis sektorius.

    organizacija
        Organizacijos pavadinimo trumpinys. Viena organizacija gali turėti
        vieną trumpinį, kuris yra registruojamas :term:`tuomenų kataloge
        <duomenų katalogas>`.

    katalogas
        Organizacijos informacinė sistemos trumpinys.

    rinkinys
        Informacinės sistemos teikiamas duomenų rinkinys.

    Visi pavadinimai užrašomi mažosiomis lotyniškomis raidėmis, žodžiams
    atskirti gali būti naudojamas `_` simbolis.

    Pagal semantinę prasmę atitinka `dcat:Resource`_.

    .. admonition:: Pavyzdys

        | `datasets/gov/rc/jar/ws`
        | `datasets/gov/ivkp/adp/adk`

    .. seealso::

        | :ref:`dataset`
        | :ref:`kodiniai-pavadinimai`

.. data:: resource

    **Duomenų šaltinis**

    Kodinis duomenų šaltinio pavadinimas, užrašomas mažosiomi slotyniškomis
    raidėmis, žodžiai skiriami `_` simboliu.

    Duomenų šaltinis yra duomenų failas, duomenų bazė ar API, per kurį teikiami
    duomenys.

    Patal semantinę prasmę atitinka `dcat:Distribution`_ arba `rml:logicalSource`_.

    .. admonition:: Pavyzdys

        | `resource1`
        | `db1`

    .. seealso::

        | :ref:`resource`
        | :ref:`duomenu-saltiniai`


.. data:: base

    **Modelio bazė**

    .. deprecated:: 0.2

       Atskira modelio bazė naikinama. Nuo 0.2 versijos, modelio bazė nurodoma
       :data:`model.type` stulpelyje.

    Kodinis bazinio modelio pavadinimas. Atitinka `rdfs:subClassOf`_ prasmę
    (:data:`model` `rdfs:subClassOf` :data:`base`). Žiūrėti :ref:`base`.


.. data:: model

    **Modelis (lentelė)**

    Kodinis modelio pavadinimas, užrašomas lotyniškomis raidėmis, kiekvieno
    žodžio pirma raidė didžioji, kitos mažosios, žodžiai atskiriami didžiąja
    raide.

    Pagal semantinę prasmę atitinka `rdfs:Class`_ arba `r2rml:SubjectMap`_.

    .. admonition:: Pavyzdys

        | `Gyvenviete`
        | `AdministracijosTipas`

    .. seealso::

        | :ref:`model`
        | :ref:`modelis`


.. data:: property

    **Savybė (stulpelis)**

    Kodinis savybės pavadinimas, užrašomas mažosiomis lotyniškomis raidėmis,
    žodžiai atskiriami `_` simoboliu.

    Savybių pavadinimai prasidedantys `_` simboliu yra rezervuoti ir turi
    apibrėžtą prasmę.

    Savybės pavadinime gali būti naudojami tokie specialūs simboliai:

    .
        (taško simbolis) nurodo objektų kompoziciją. Naudojamas su
        :data:`ref <type.ref>` ir :data:`object <type.object>` duomenų tipais.

        .. admonition:: Pavyzdys

            | `adresas.gatve`

    []
        Duomenų masyvas arba sąrašas, gali būti naudojamas su visais tipais.

        .. admonition:: Pavyzdys

            | `miestai[]`

    @
        Kalbos žymė, naudojama su :data:`text <type.text>` tipu.

        .. admonition:: Pavyzdys

            | `pavadinimas@lt`
            | `pavadinimas@en`

    Pagal semantinę prasmę atitinka `rdfs:Property`_,
    `r2rml:PredicateObjectMap`_.

    .. seealso::

        | :ref:`property`



.. _metaduomenų-stulpeliai:

Metaduomenys
************

Kaip ir minėta aukščiau, kiekvienos metaduomenų eilutės prasmė priklauso nuo
:ref:`dimensijos`. Todėl, toliau dokumentacijoje, kalbant apie tam tikros
dimensijos stulpelį, stulpelis bus įvardinamas pridedant dimensijos
pavadinimą, pavyzdžiui :data:`model.ref`, kas reikštų, kad kalbama apie
:data:`ref` stulpelį, :data:`model` dimensijoje.

.. data:: id

    **Eilutės identifikatorius**

    Unikalus elemento numeris, gali būti sveikas, monotoniškai didėjantis
    skaičius arba UUID. Svarbu užtikrinti, kad visi elementai turėtu unikalų id.

    Šis stulpelis pildomas automatinėmis priemonėmis, siekiant identifikuoti
    konkrečias metaduomenų eilutes, kad būtų galima atpažinti metaduomenis,
    kurie jau buvo pateikti ir po to atnaujinti.

    Šio stulpelio pildyti nereikia.

.. data:: type

    **Tipas**

    Prasmė priklauso nuo dimensijos. Žiūrėti :ref:`duomenų-tipai`.

    Jei nenurodytas nei vienas :ref:`dimensijos stulpelis
    <dimensijos-stulpeliai>`, tuomet šiame stulpelyje nurodoma :ref:`papildoma
    dimensija <papildomos-dimensijos>`.

.. data:: ref

    **Ryšys**

    Prasmė priklauso nuo dimensijos. Žiūrėti :ref:`ryšiai`,
    :ref:`matavimo-vienetai` ir :ref:`enum`.

.. data:: source

    **Šaltinis**

    Duomenų šaltinio struktūros elementai. Žiūrėti :ref:`duomenų-šaltiniai`.

.. data:: prepare

    **Formulė**

    Formulė skirta duomenų atrankai, nuasmeninimui, transformavimui, tikrinimui
    ir pan. Žiūrėti :ref:`formulės`.

.. data:: level

    **Brandos lygis**

    Duomenų brandos lygis, atitinka `5 Star Data`_. Žiūrėti
    :ref:`level`.

    .. _5 Star Data: https://5stardata.info/en/

.. data:: access

    **Prieiga**

    Duomenų prieigos lygis. Žiūrėti :ref:`access`.

.. data:: uri

    **Žodyno atitikmuo**

    Sąsaja su išoriniu žodynu. Žiūrėti :ref:`vocab`.

.. data:: title

    **Pavadinimas**

    Elemento pavadinimas.

.. data:: description

    **Aprašymas**

    Elemento aprašymas. Galima naudoti Markdown_ sintaksę.

    .. _Markdown: https://en.wikipedia.org/wiki/Markdown

Visi stulpeliai lentelėje yra neprivalomi. Stulpelių tvarka taip pat nėra
svarbi. Pavyzdžiui jei reikia apsirašyti tik globalių modelių struktūrą,
nebūtina įtraukti :data:`dataset`, :data:`resource` ir :data:`base` stulpelių.
Jei norima apsirašyti tik prefiksus naudojamus :data:`uri` lauke, užtenka
turėti tik prefiksų aprašymui reikalingus stulpelius.

Įrankiai skaitantys :term:`DSA`, stulpelius, kurių nėra lentelėje turi
interpretuoti kaip tuščius. Taip pat įrankiai neturėtų tikėtis, kad stulpeliai
bus išdėstyti būtent tokia tvarka. Nors įrankių atžvilgiu stulpelių tvarka nėra
svarbi, tačiau rekomenduotina išlaikyti vienodą stulpelių tvarką, tam kad
lenteles būtų lengviau skaityti.



.. _Duomenų katalogą: https://data.gov.lt/
.. _dcat:Resource: https://www.w3.org/TR/vocab-dcat-2/#Class:Resource
.. _rml:logicalSource: https://rml.io/specs/rml/#logical-source
.. _dcat:Distribution: https://www.w3.org/TR/vocab-dcat-2/#Class:Distribution
.. _dcat:DataService: https://www.w3.org/TR/vocab-dcat-2/#Class:DataService
.. _r2rml:SubjectMap: https://www.w3.org/TR/r2rml/#subject-map
.. _rdfs:Class: https://www.w3.org/TR/rdf-schema/#ch_class
.. _rdfs:subClassOf: https://www.w3.org/TR/rdf-schema/#ch_subclassof
.. _r2rml:PredicateObjectMap: https://www.w3.org/TR/r2rml/#predicate-object-map
.. _rdfs:Property: https://www.w3.org/TR/rdf-schema/#ch_property
