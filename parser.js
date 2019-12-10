const fs = require('fs');
const puppetter = require('puppeteer');
const xpath = require('xpath');
var message = process.argv.slice(2);

console.log('[!] Start Encoding...');
console.log('[+] Message: ', message.join(' '));

(async () => {
    const browser = await puppetter.launch();
    const page = await browser.newPage();
    const url = "http://smstools3.kekekasvi.com/topic.php?id=288";
    const inputSelector = "#smsText";
    const submitSelector = "#pduTool > table:nth-child(1) > tbody:nth-child(1) > tr:nth-child(8) > td:nth-child(5) > input:nth-child(1)";
    const outputSelector = "#ussdText";
    let bytes_code = "01";

    await page.goto(url);

    await page.$eval(inputSelector, (el, message) => {
        el.value = message;
    }, message);

    await page.$eval(submitSelector, (el) => {
        el.click();
    });

    bytes_code += await page.$eval(outputSelector, (el) => {
        return el.value;
    });

    console.log("---");
    console.log("[!] Result:", bytes_code);
    console.log("---");

    // await page.screenshot({path: 'test.png', fullPage: true});
    await browser.close();
    console.log('[!] Finish Encoding!\n');

    console.log('[*] Writing to Files...');
    let tmp = ""

    await fs.writeFile('bytes_code', '', (err) => {});

    for (text in bytes_code) {
        tmp += bytes_code[text];
        if (text % 2) {
            await fs.appendFileSync('bytes_code', tmp, (err) => {
                console.log(tmp);
                if (err) throw err;
            });
            tmp = "\n";
        }
    }
    console.log('[+] Bytes Code Saved!\n');
    
})();
