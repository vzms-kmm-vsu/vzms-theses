const fs = require('fs');
const ls = require('ls');

const texFiles = ls('Data/**.tex');


const possibleLitListHeadings = [
	'\\smallskip \\centerline {\\bf Литература} \\nopagebreak',
	'\\centerline {\\bf Литература}',
	'\\smallskip \\centerline{\\bf Литература}\\nopagebreak',
	'\\smallskip \\centerline {\\bf Bibliography} \\nopagebreak',
	'\\centerline {\\bf Bibliography}'
];

texFiles.map((file) => {
	let rows = fs.readFileSync(file.full,'utf-8').split("\n");
	let changed = false;

	for(let i = 0; i < rows.length; i++){
		let row = rows[i];
		if (row.trim() == '\\litlist') {
			// Список литературы в файле уже оформлен как надо
			if (rows[i+1] && rows[i+1].trim()) {
				rows[i] += "\n";
				changed = true;
				break;
			}
			if (rows[i-1] && rows[i-1].trim()) {
				rows[i] = "\n" + rows[i];
				changed = true;
				break;
			}
			return;
		}
		for (let possibleRow of possibleLitListHeadings) {
			if (row.trim() == possibleRow){
				rows[i] = '\\litlist';
				changed = true;
				break;
			}
		}
	}
	if (changed) {
		fs.writeFileSync(file.full,rows.join("\n"))
	} else {
		console.log(file.full + " : no litlist heading");
	}
})
