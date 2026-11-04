var all_data = [];

fetch("/api/vulnerabilities")
  .then(res => res.json())
  .then(data => {
    all_data = data;
    drawTable(document.querySelector("#filters button"), "All"); 
  });

function drawTable(clickedBtn, filter) {
  var buttons = document.querySelectorAll("#filters button");
  for (var i = 0; i < buttons.length; i++) {
    buttons[i].className = "";
  }
  
  clickedBtn.className = "on";

  var filtered = all_data.filter(v => filter === "All" || v.severity === filter);
  
  document.getElementById("rows").innerHTML = filtered.map(v => `
    <tr>
      <td>${v.team}</td>
      <td>${v.client}</td>
      <td>${v.vulnerability}</td>
      <td><span class="tag" style="background:var(--${v.severity})">${v.severity}</span></td>
      <td>${v.method}</td>
    </tr>
  `).join('');
}