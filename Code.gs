function doGet() {
  const htmlService = HtmlService.createTemplateFromFile("index");
  htmlService.categories = getCategories_();
  const html = htmlService
    .evaluate()
    .addMetaTag(
      "viewport",
      "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
    );
  return html;
}

function getCategories_() {
  const ss = SpreadsheetApp.getActiveSpreadsheet(); // Corrected function name
  const ws = ss.getSheetByName("VAlidation");
  const categories = ws
    .getRange("A18:A50")
    .getValues()
    .filter((r) => r[0] !== "")
    .map((r) => r[0]);
  return categories;
}

function acceptData(formData) {
  console.log(formData);

  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const ws = ss.getSheetByName("Transactions");

  // Specify the column indices for each form field
  const columnIndices = {
    date: 2, // Column B
    itemDescription: 7, // Column G
    amount: 5, // Column E
    amountReceivable: 6, // Column f
    category2: 8, // Column H
  };

  // Construct an array with the form field values in the correct order
  const rowData = [
    formData.date,
    formData.itemDescription,
    formData.amount,
    formData.amountReceivable,
    formData.category2,
  ];

  // Construct the range using the specified column indices
  const range = ws.getRange(ws.getLastRow() + 1, 2, 1, rowData.length);

  // Set the values in the range
  range.setValues([rowData]);
}
