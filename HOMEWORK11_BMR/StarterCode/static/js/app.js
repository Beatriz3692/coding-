// Get references to the tbody element
var body = document.querySelector("tbody");
var date = d3.select("#date");
var city = d3.select("#city");
var state = d3.select("#state");
var country = d3.select("#country");
var shape = d3.select("#shape");
var search_button = d3.select("#search");

// Add event listener to the search button, call handleSearchClick
search_button.on("click", handleSearchClick);

// create variable connected to data
var ufo_data = data;

// create table
function tableCreate() {
    body.innerHTML = "";
    for (var i = 0; i < ufo_data.length; i++) {
        var info = ufo_data[i];
        var fields = Object.keys(info);
        let row = body.insertRow(i);
        for (var j = 0; j < fields.length; j++) {
            var field = fields[j];
            let cell = row.insertCell(j);
            cell.innerText = info[field];
        }
    }
}

function handleSearchClick() {

    var filterDate = date.value.val();
    var filterCity = city.value.trim().toLowerCase();
    var filterState = state.value.trim().toLowerCase();
    var filterCountry = country.value.trim().toLowerCase();
    var filterShape = shape.value.trim().toLowerCase();

    ufo_data = data.filter(function(ufoSighting) {
        var searchDate = ufoSighting.datetime;
        var searchCity = ufoSighting.city.toLowerCase();
        var searchState = ufoSighting.state.toLowerCase();
        var searchCountry = ufoSighting.country.toLowerCase();
        var searchShape = ufoSighting.shape.toLowerCase();

        if (
            (searchDate === filterDate || filterDate === "") &&
            (searchCity === filterCity || filterCity === "") &&
            (searchState === filterState || filterState === "") &&
            (searchCountry === filterCountry || filterCountry === "") &&
            (searchShape === filterShape || filterShape === "")
        ) {
            return true;
        }
        return false;
    });
    tableCreate();

    // Clear input fields
    date.value = "";
    city.value = "";
    state.value = "";
    country.value = "";
    shape.value = "";
}

tableCreate();
