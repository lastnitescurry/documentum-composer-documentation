# documentum-composer-documentation

Play ground for transforming Documentum Composer XML definition files into useful documentation for management.
Now that the world has moved to Github/Gitlab/... plain text markdown is a superior format compared to HTML.
* minimal plain text so can be added to source code along with Composer changes
* Github & Gitlab can render into pretty format for managers

After discovering http://ant2dot.sourceforge.net I added generation of a object model diagram

## Key Files
- [example source object model xml](HelloWorld/Artifacts/Types/ie_document.type)
- [maven pom to run transform](HelloWorld/pom.xml)

#### Type to Markdown
- [xslt to do transform](HelloWorld/src/xslt/types_to_markdown.xsl)
- [Generated Markdown file of Object Type](HelloWorld/src/site/markdown/Types/ie_document.md)

#### dardef and types to object model diagram
- [xslt to do transform](HelloWorld/src/xslt/type2dot.xsl)
- [Object Model - SVG](HelloWorld/src/site/resources/default.dardef.svg)
- [Object Model - PDF](HelloWorld/src/site/resources/default.dardef.pdf)
- [Object Model - PNG](HelloWorld/src/site/resources/default.dardef.png)

## References

- http://paulcwarren.wordpress.com/2009/05/29/dardocs/
- https://gist.github.com/gabetax/1702774


## XSLT to Graohwiz DOT

- http://ant2dot.sourceforge.net/#how
- http://stackoverflow.com/questions/8959683/xslt-taking-2-xml-files-as-input-and-generating-output-xml-file
- http://stackoverflow.com/questions/18549777/how-to-process-all-data-from-multiple-xml-files-after-merging-using-xsl
- http://www.ibm.com/developerworks/library/x-tipcombxslt/

#### Interactive graphs
- http://stamm-wilbrandt.de/GraphvizFiddle
- http://www.graphviz.org/content/interactive-graphs

