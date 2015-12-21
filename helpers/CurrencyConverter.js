var request = require('bluebird').promisifyAll(require('request'));
var cheerio = require('cheerio');

var fromCurrency = process.argv[2] || 'usd';
var toCurrency = process.argv[3] || 'try';
var amount = process.argv[4] || 1;

if(process.argv[2] === '-h'){
  console.log('usage: fx <from> <to> <amount>');
  process.exit();
}

function parseResult(res){
  var $ = cheerio.load(res.body);
  if($){
    return {
      from: $('#currency_converter_result').html().split('<span')[0],
      to: $('#currency_converter_result > .bld').html()
    };
  }
}

function log(conversion){
  console.log(conversion.from + conversion.to);
}
request.getAsync('https://www.google.com/finance/converter?a='+amount+'&from='+fromCurrency+'&to='+toCurrency)
  .then(parseResult)
  .then(log)
  .catch(console.error);
