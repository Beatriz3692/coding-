// Define SVG area dimensions
var svgWidth = 960;
var svgHeight = 660;

// Define the chart's margins as an object
var chartMargin = {
  top: 30,
  right: 30,
  bottom: 200,
  left: 100
};

// Define dimensions of the chart area
var chartWidth = svgWidth - chartMargin.left - chartMargin.right;
var chartHeight = svgHeight - chartMargin.top - chartMargin.bottom;

// Select body, append SVG area to it, and set the dimensions
var svg = d3.select("body")
  .append("svg")
  .attr("height", svgHeight)
  .attr("width", svgWidth);

// Append a group to the SVG area and shift ('translate') it to the right and to the bottom
var chartGroup = svg.append("g")
  .attr("transform", `translate(${chartMargin.left}, ${chartMargin.top})`);

// Load data from data.csv
d3.csv("data.csv", function(error, healthData) {
  if (error) throw error;
console.log(healthData)

// Step 1: Parse Data/Cast as numbers
  healthData.forEach(function(d) {
    d.poverty = +d.poverty;
    d.healthcare = +d.healthcare;
  });

// Step 2: Create scale functions
var yLinearScale = d3.scaleLinear()
  .domain([d3.min(healthData, d => d.healthcare)-1, d3.max(healthData, d => d.healthcare)+1.1])
  .range([chartHeight, 0]);
var xLinearScale = d3.scaleLinear()
  .domain([d3.min(healthData, d => d.poverty)-0.5, d3.max(healthData, d => d.poverty)+0.5, 30])
  .range([0, chartWidth]);

// Step 3: Create axis functions
var bottomAxis = d3.axisBottom(xLinearScale);
var leftAxis = d3.axisLeft(yLinearScale);

// Append two SVG group elements to the chartGroup area,
// and create the bottom and left axes inside of them
chartGroup.append("g")
  .call(leftAxis);

chartGroup.append("g")
  .attr("transform", `translate(0, ${chartHeight})`)
  .call(bottomAxis);

  //Create Circles
var circlesGroup = chart.selectAll("circle").data(healthData).enter();
  .data(healthData)
  .enter()
  .append("circle")
  .attr("cx", d => xLinearScale(d.poverty))
  .attr("cy", d => yLinearScale(d.healthcare))
  .attr("fill", "pink")
  .attr("r", "15")
  .attr("opacity", ".5");

  .on("mouseout", function(data, index) {
  toolTip.hide(data);
});

//Initialize tool tip
var toolTip = d3.tip()
   .attr("class", "tooltip")
   .offset([80, -60])
   .html(function(d) {
     return (abbr + '%');
     });

//Create tooltip in the chart
chartGroup.call(toolTip);

//Create event listeners to display and hide the tooltip
circlesGroup.on("click", function(data) {
   toolTip.show(data);
 })
 // onmouseout event
  .on("mouseout", function(data, index) {
    toolTip.hide(data);
  });

  // Create axes labels

   chartGroup.append("text")
   .style("font-size", "12px")
   .selectAll("tspan")
   .data(healthData)
   .enter()
   .append("tspan")
       .attr("x", function(data) {
           return xLinearScale(data.healthcare +1.3);
       })
       .attr("y", function(data) {
           return yLinearScale(data.poverty +.1);
       })
       .text(function(data) {
           return data.abbr
       });

   chartGroup.append("text")
     .attr("transform", "rotate(-90)")
     .attr("y", 0 - margin.left + 40)
     .attr("x", 0 - (height / 2))
     .attr("dy", "1em")
     .attr("class", "axisText")
     .text("Lacks Healtcare(%)");

   chartGroup.append("g")
     .attr("transform", `translate(${width / 2}, ${height + margin.top + 30})`)
     .attr("class", "axisText")
     .text("In Poverty (%)");
 });
