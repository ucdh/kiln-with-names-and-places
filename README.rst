Kiln: with names and places
===========================

Kiln is an open source multi-platform framework for building and deploying
complex websites whose source content is primarily in XML. It brings together
various independent software components into an integrated whole that provides
the infrastructure and base functionality for such sites.

Kiln is developed and maintained by a team at the Department of
Digital Humanities (DDH), King’s College London. Over the past years
and versions, Kiln has been used to generate more than 50 websites
which have very different source materials and customised
functionality. It has been adapted to work on a variety of flavours of
TEI and other XML vocabularies, and has been used to publish data held
in relational databases.

**This version of Kiln includes a name and places page** which allows users
to browse through an alphabeticised list of names and places extracted from
the XML files. Users can click on a name or place for more information plus
a list of files that reference that name or place.


To create your name and place page:

Generate a Metadata Authority Description Schema (MADS) file using the 
Python code in the scripts folder (/webapps/ROOT/assets/scripts/addnames)

- Add your files to the TEI_IN folder
- Run addnames.py using Python 2.7
- Check error messages for missed names

The MADS file can be added to by running the script again over new XML files. 
Changes to names in the MADS file must be made manually or by removing the 
instance and rerunning the script.

Code
----

Names and Places: https://github.com/ljewalsh/kiln

Original: https://github.com/kcl-ddh/kiln/

Kiln Documentation
------------------

http://kiln.readthedocs.org/en/latest/

MADS Documentation
------------------
http://www.loc.gov/standards/mads/