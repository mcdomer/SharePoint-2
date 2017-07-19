$().SPServices({
  operation: "GetVersionCollection",
  async: false,
  strlistID: "ITRequest",
  strlistItemID: 210,
  strFieldName: "Editor",
  completefunc: function(xData, Status) {
    //console.log(xData);
	var versionsText = "";
    $(xData.responseText).find("Version").each(function(i) {
      var editorVar = "";
      editorVar = ($(this).attr("Editor")).split('#').pop();

      var dateVar = null;
      dateVar = new Date($(this).attr("Modified"));

      if(editorVar != "Adminsharepoint")
      {
        versionsText += "Modified By: " + editorVar + " Modified: " + dateVar.toLocaleString() + '\n';
      }
    });
	console.log(versionsText);
  }
});