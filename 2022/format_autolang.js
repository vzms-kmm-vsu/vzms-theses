const fs = require('fs');
const ls = require('ls');

const texFiles = ls('Data/**.tex');


function isParagraphRussian(text){
	if (text.trim()[0] === "%") {
		// That's a comment!
		return false;
	}
	let foundRussianLetters = text.match(/[а-яё]/gi);
	return foundRussianLetters && foundRussianLetters.length > 32;
}

function isParagraphEnglish(text){
	if (text.trim()[0] === "%") {
		// That's a comment!
		return false;
	}
	let foundRussianLetters = text.match(/[а-яё]/gi);
	let foundEnglishLetters = text.match(/[a-z]/gi);
	return !foundRussianLetters && foundEnglishLetters && foundEnglishLetters.length > 32;
}


function fixParapraphLanguage(previous, current){

	console.log(current);
	console.log(isParagraphEnglish(current), isParagraphRussian(current));

	if(isParagraphEnglish(current) && isParagraphRussian(previous)) {
		return "\n\\selectlanguage{english}\n";
	}

	if(isParagraphRussian(current) && isParagraphEnglish(previous)) {
		return "\n\\selectlanguage{russian}\n";
	}


	return "";

}

function splitTextIntoParagraphs(text){
	let pos = text.search(/\n\r*\n[\n\r]*/);
	console.log(pos);
	if (pos === -1) {
		return [text];
	}
	return [text.substr(0,pos + 1)].concat(splitTextIntoParagraphs(text.substr(pos + 1)));
}


texFiles.map((file) => {

/*
	if(file.full !== 'Data/Скворцов.tex'){
		return;
	}
*/
	//let rows = fs.readFileSync(file.full,'utf-8').split(/(\n(?=\n+))|(\n(?=(\n\r)*))/g);
	let rows = splitTextIntoParagraphs(
		fs.readFileSync(file.full,'utf-8')
	);

	console.log(rows);


	let litlistIndex;

	for (litlistIndex = 0; litlistIndex < rows.length; litlistIndex++){
		let row = rows[litlistIndex];
		if (row.trim() == '\\litlist') {
			// Нашли место, где начинается список литературы
			break;
		}
	}

	if (litlistIndex == rows.length) {
		console.log(file.full + " : no litlist heading");
		return;
	}

	// Проверяем совместимость первой сылки с языком текста тезисов
	rows[litlistIndex + 1] = fixParapraphLanguage(rows[litlistIndex - 1], rows[litlistIndex + 1]) + rows[litlistIndex + 1];

	for (let i = litlistIndex + 2; i < rows.length; i++){
		for (var j = i - 1; j >= 0; j--){
			if(rows[j].trim()){
				break;
			}
		}
		rows[i] = fixParapraphLanguage(rows[j], rows[i]) + rows[i];
	}

	fs.writeFileSync(file.full,rows.join(""))

});
