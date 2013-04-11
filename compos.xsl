<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">

<xsl:template match="/">

<html>
<head>
	<title>Fallen Galaxy Fleet Compositions</title>
	<link rel="stylesheet" href="compos.css" />
</head>
<body>
	<xsl:for-each select="fleets/category">
		<xsl:sort select="name"/>

		<h1><xsl:value-of select="name" /></h1>

		<xsl:for-each select="compo">
			<xsl:sort select="name"/>

			<div>
				<!--xsl:if test="@id">
					<xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
				</xsl:if-->
				<xsl:choose>
					<xsl:when test="@faction">
						<xsl:attribute name="class">
							<xsl:value-of select="concat('compo ', @faction)" />
						</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">compo allFactions</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<h2 class="compname">
					<span class="factionimage"></span>

					<xsl:value-of select="name" />

					<xsl:if test="@type = 'aggressive' or @type = 'defensive'">
						<span class="{@type}"></span>
					</xsl:if>
				</h2>

				<xsl:if test="@min-tech or @min-pow">
					<p class="minPower">
						<xsl:if test="@min-tech">
							<xsl:value-of select="@min-tech" />
							<span class="tech"></span>
						</xsl:if>
						<xsl:text> </xsl:text>
						<xsl:if test="@min-pow">
							<xsl:value-of select="@min-pow" />
							<span class="power"></span>
						</xsl:if>
					</p>
				</xsl:if>

				<xsl:if test="@faction">
					<p class="faction">
						<xsl:choose>
							<xsl:when test="@faction = 'GalacticDiplomaticOffice'">Galactic Diplomatic Office</xsl:when>
							<xsl:when test="@faction = 'AutonomousNetwork'">Autonomous Network</xsl:when>
							<xsl:otherwise><xsl:value-of select="@faction" /></xsl:otherwise>
						</xsl:choose>
					</p>
				</xsl:if>

				<xsl:if test="ships">
					<div class="fleet">
						<xsl:for-each select="ships/*">
							<div class="{name(.)}Ships ships">
								<xsl:for-each select="ship">
									<!--xsl:sort select="@amount"/> Do not do it! The order is important. -->
									<div class="ship">
										<div class="shipimage {.}"></div>
										<div class="amount">
											<span class="amount{@amount}">
												<xsl:choose>
													<xsl:when test="@amount = '1'">lots of</xsl:when>
													<xsl:when test="@amount = '2'">many</xsl:when>
													<xsl:when test="@amount = '3'">some</xsl:when>
													<xsl:when test="@amount = '4'">few</xsl:when>
													<xsl:when test="@amount = '5'">very few</xsl:when>
													<xsl:otherwise>???</xsl:otherwise>
												</xsl:choose>
											</span>
										</div>
										<xsl:value-of select="." />
									</div>
								</xsl:for-each>
							</div>
						</xsl:for-each>
					</div>
				</xsl:if>

				<xsl:if test="strength or weakness">
					<div class="counters">
						<h3>Counters</h3>
						<xsl:if test="strength">
							<div class="strongCounter">
								<h4>Strong against</h4>
								<ul>
									<xsl:for-each select="strength">
										<xsl:call-template name="weakandstrong" />
									</xsl:for-each>
								</ul>
							</div>
						</xsl:if>
						<xsl:if test="weakness">
							<div class="weakCounter">
								<h4>Weak against</h4>
								<ul>
									<xsl:for-each select="weakness">
										<xsl:call-template name="weakandstrong" />
									</xsl:for-each>
								</ul>
							</div>
						</xsl:if>
					</div>
				</xsl:if>
				<xsl:if test="note">
					<div class="notes">
						<h4>Notes</h4>
						<ul>
							<xsl:for-each select="note">
								<li class="note"><xsl:value-of select="."/></li>
							</xsl:for-each>
						</ul>
					</div>
				</xsl:if>
			</div>
		</xsl:for-each>
	</xsl:for-each>
	<script type="text/javascript">

var links = document.getElementsByClassName("compo-type-link");
var compos = document.getElementsByTagName("h2");
var compoNames = [];
var id, idx, text;

for(var i = 0, l = compos.length; i &lt; l; ++i) {
	compoNames[i] = compos[i].textContent;
}

for(var i = 0, l = links.length; i &lt; l; ++i) {
	text = links[i].textContent;
	idx = compoNames.indexOf(text);
	if(idx >= 0) {
		id = text.replace(/[^a-z0-9]+/i, "-")
			.replace(/([A-Z])/, "-$1").replace(/-+/, "-")
			.replace(/^-*/, "").toLowerCase();
		compos[idx].id = id;
		links[i].href = "#"+id;
	}
}

	</script>
</body>
</html>

</xsl:template>

<xsl:template name="weakandstrong">
	<li>
		<a class="compo-type-link"><xsl:value-of select="." /></a>
		<!--xsl:choose>
			<xsl:when test="@to">
				<a href="#{@to}"><xsl:value-of select="." /></a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose-->
	</li>
</xsl:template>

</xsl:stylesheet> 
