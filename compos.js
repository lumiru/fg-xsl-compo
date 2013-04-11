var links = document.getElementsByClassName("compo-type-link");
var compos = document.getElementsByTagName("h2");
var compoNames = [];
var id, idx, text;
var i, l;

var variations = document.getElementsByClassName("variation");

for(i = 0, l = compos.length; i < l; ++i) {
	compoNames[i] = compos[i].textContent;
}

for(i = 0, l = links.length; i < l; ++i) {
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

function chooseVariation(variation) {
	return function() {
		var compo = variation.parentNode.parentNode;
		var currentFleet = compo.getElementsByClassName("fleet").item(0);
		var selectedVariations = variation.parentNode.getElementsByClassName("selected");
		var nodes = variation.getElementsByClassName("ships").item(0).childNodes;
		var i, l;

		while(currentFleet.firstChild) currentFleet.removeChild(currentFleet.firstChild);

		for(i = 0, l = nodes.length; i < l; ++i) {
			currentFleet.appendChild(nodes[i].cloneNode(true));
		}

		for(i = 0, l = selectedVariations.length; i < l; ++i) {
			selectedVariations[i].className = "variation";
		}
		variation.className = "variation selected";
	};
}

for(i = 0, l = variations.length; i < l; ++i) {
	variations[i].getElementsByTagName("h4").item(0)
		.addEventListener("click", chooseVariation(variations[i]), false);
}
