<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <!-- Define parameters for search -->
    <xsl:param name="author"/>
    <xsl:param name="year"/>
    
    <!-- Define Euro to DZD conversion rate -->
    <xsl:variable name="eur_to_dzd" select="145"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Infinity Book ∞</title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <link rel="icon" href="favicon.ico" type="image/x-icon"/>
                <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
                <link rel="stylesheet" type="text/css" href="style.css"/>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
            </head>
            <body>
                <div class="container">
                    <header>
                        <h1><i class="fas fa-infinity"></i> Infinity Book</h1>
                        <p class="subtitle"><i class="fas fa-book-open"></i> Collection de Livres Classiques</p>
                    </header>

                    <div class="search-container">
                        <form method="GET" class="search-box" action="index.html">
                            <div class="search-input">
                                <i class="fas fa-user-pen"></i>
                                <input type="text" name="author" placeholder="Rechercher par auteur...">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="$author"/>
                                    </xsl:attribute>
                                </input>
                            </div>
                            <div class="search-input">
                                <i class="fas fa-calendar"></i>
                                <input type="text" name="year" placeholder="Rechercher par année...">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="$year"/>
                                    </xsl:attribute>
                                </input>
                            </div>
                            <button type="submit" class="search-button">
                                <i class="fas fa-search"></i> Rechercher
                            </button>
                            <a href="?" class="reset-button">
                                <i class="fas fa-undo"></i> Réinitialiser
                            </a>
                        </form>
                        
                        <!-- Add search results count -->
                        <xsl:if test="$author != '' or $year != ''">
                            <div class="search-results">
                                <xsl:variable name="resultCount" select="count(bibliotheque/livre[
                                    (not($author) or contains(translate(auteur, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),
                                    translate($author, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')))
                                    and
                                    (not($year) or contains(annee, $year))
                                    ])"/>
                                <p>
                                    <i class="fas fa-info-circle"></i>
                                    <xsl:choose>
                                        <xsl:when test="$resultCount = 0">
                                            Aucun résultat trouvé pour votre recherche.
                                        </xsl:when>
                                        <xsl:when test="$resultCount = 1">
                                            1 livre trouvé.
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$resultCount"/> livres trouvés.
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </p>
                            </div>
                        </xsl:if>
                    </div>

                    <div class="books-grid">
                        <!-- Improved search logic -->
                        <xsl:for-each select="bibliotheque/livre[
                            (not($author) or contains(translate(auteur, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),
                            translate($author, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')))
                            and
                            (not($year) or contains(annee, $year))
                            ]">
                            <xsl:sort select="titre"/>
                            <div class="book-card">
                                <div class="book-title">
                                    <i class="fas fa-book text-primary"></i>
                                    <h3><xsl:value-of select="titre"/></h3>
                                </div>
                                <div class="book-info">
                                    <div class="book-author">
                                        <i class="fas fa-user text-info"></i>
                                        <span><xsl:value-of select="auteur"/></span>
                                    </div>
                                    <div class="book-year">
                                        <i class="far fa-calendar text-secondary"></i>
                                        <span><xsl:value-of select="annee"/></span>
                                    </div>
                                    <div class="book-genre">
                                        <i class="fas fa-tag text-dark"></i>
                                        <span><xsl:value-of select="genre"/></span>
                                    </div>
                                </div>
                                <div class="book-details">
                                    <div class="book-quantity">
                                        <i class="fas fa-box"></i>
                                        <span>Quantité: <xsl:value-of select="quantite"/></span>
                                    </div>
                                    <div class="book-price">
                                        <i class="fas fa-coins"></i>
                                        <span><xsl:value-of select="format-number(prix, '#,##0.00')"/> DA</span>
                                    </div>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>

                    <footer>
                        <p><i class="fas fa-sort-alpha-up"></i> Triés par titre</p>
                        <p><i class="fas fa-exchange-alt"></i> 1 EUR = <xsl:value-of select="$eur_to_dzd"/> DZD</p>
                    </footer>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>