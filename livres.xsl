<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:legacy-compat"/>
    
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
                <!-- Critical inline styles for dark mode -->
                <style>
                    :root {
                        --bg-primary: linear-gradient(135deg, #f5f0eb 0%, #e6dfd9 100%);
                        --bg-secondary: #ffffff;
                        --text-primary: #4a3728;
                        --text-secondary: #6b4423;
                        --accent-primary: #8b5e3c;
                        --accent-secondary: #6b4423;
                        --border-color: rgba(255,255,255,0.8);
                        --shadow-color: rgba(74, 55, 40, 0.08);
                        --shadow-hover: rgba(74, 55, 40, 0.15);
                        --card-bg: #ffffff;
                        --book-cover-bg: linear-gradient(135deg, #f5f0eb 0%, #e6dfd9 100%);
                        --book-pages: #f8f4f1;
                        --highlight-color: #f5c542;
                    }
                    
                    [data-theme="dark"] {
                        --bg-primary: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);
                        --bg-secondary: #333333;
                        --text-primary: #e6e6e6;
                        --text-secondary: #cccccc;
                        --accent-primary: #c28d54;
                        --accent-secondary: #a67642;
                        --border-color: rgba(80, 80, 80, 0.8);
                        --shadow-color: rgba(0, 0, 0, 0.2);
                        --shadow-hover: rgba(0, 0, 0, 0.3);
                        --card-bg: #2a2a2a;
                        --book-cover-bg: linear-gradient(135deg, #3a3a3a 0%, #2a2a2a 100%);
                        --book-pages: #444444;
                        --highlight-color: #f5c542;
                    }
                    
                    body {
                        font-family: 'Segoe UI', Arial, sans-serif;
                        margin: 0;
                        padding: 0;
                        background: var(--bg-primary);
                        color: var(--text-primary);
                        min-height: 100vh;
                        position: relative;
                        transition: all 0.3s ease;
                    }
                    
                    .container {
                        max-width: 1200px;
                        margin: 2rem auto;
                        padding: 0 20px;
                    }
                    
                    header {
                        text-align: center;
                        margin-bottom: 3rem;
                        padding: 3rem 2rem;
                        background: var(--bg-secondary);
                        border-radius: 15px;
                        box-shadow: 0 10px 20px var(--shadow-color);
                        border: 1px solid var(--border-color);
                        position: relative;
                        overflow: hidden;
                        transition: all 0.3s ease;
                    }
                    
                    .theme-toggle {
                        position: absolute;
                        top: 20px;
                        right: 20px;
                        background: none;
                        border: none;
                        cursor: pointer;
                        font-size: 1.5rem;
                        color: var(--accent-primary);
                        z-index: 10;
                        transition: all 0.3s ease;
                        padding: 8px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        background-color: rgba(255, 255, 255, 0.1);
                    }
                    
                    .theme-toggle:hover {
                        transform: rotate(30deg);
                    }
                    
                    .theme-toggle .fa-sun {
                        display: none;
                    }
                    
                    .theme-toggle .fa-moon {
                        display: block;
                    }
                    
                    [data-theme="dark"] .theme-toggle .fa-sun {
                        display: block;
                    }
                    
                    [data-theme="dark"] .theme-toggle .fa-moon {
                        display: none;
                    }
                    
                    .book-card {
                        background: var(--card-bg);
                        border-radius: 15px;
                        box-shadow: 0 10px 20px var(--shadow-color);
                        border: 1px solid var(--border-color);
                    }
                    
                    .search-container {
                        background: var(--bg-secondary);
                        border-radius: 15px;
                        box-shadow: 0 10px 20px var(--shadow-color);
                        border: 1px solid var(--border-color);
                    }
                </style>
                <!-- External CSS -->
                <link rel="stylesheet" type="text/css" href="style.css"/>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
                <script>
                    // Function to toggle between light and dark mode
                    function toggleTheme() {
                        const body = document.body;
                        if (body.getAttribute('data-theme') === 'dark') {
                            body.removeAttribute('data-theme');
                            localStorage.setItem('theme', 'light');
                        } else {
                            body.setAttribute('data-theme', 'dark');
                            localStorage.setItem('theme', 'dark');
                        }
                    }
                    
                    // Apply the theme from localStorage
                    document.addEventListener('DOMContentLoaded', function() {
                        const savedTheme = localStorage.getItem('theme');
                        if (savedTheme === 'dark') {
                            document.body.setAttribute('data-theme', 'dark');
                        }
                        
                        // Add click event to theme toggle button
                        const themeToggle = document.querySelector('.theme-toggle');
                        if (themeToggle) {
                            themeToggle.addEventListener('click', toggleTheme);
                        }
                    });
                </script>
            </head>
            <body>
                <div class="container">
                    <header>
                        <button class="theme-toggle" type="button" aria-label="Toggle dark mode">
                            <i class="fas fa-moon"></i>
                            <i class="fas fa-sun"></i>
                        </button>
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
                                <div class="book-cover-side">
                                    <xsl:choose>
                                        <xsl:when test="image">
                                            <div class="book-image-container">
                                                <img>
                                                    <xsl:attribute name="src">
                                                        <xsl:value-of select="image"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="alt">
                                                        <xsl:value-of select="titre"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="class">book-image</xsl:attribute>
                                                </img>
                                            </div>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <div class="no-image-container">
                                                <div class="no-image">
                                                    <i class="fas fa-book-open"></i>
                                                </div>
                                            </div>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                                <div class="book-content">
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