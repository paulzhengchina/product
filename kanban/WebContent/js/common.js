function formateBRForTextArea()
{
	var textAreaValue=$("textarea").text();
	if(textAreaValue.indexOf("<br>") !=-1){
		textAreaValue.replace(/<br>/, "\n\t");		
	}
	else if(textAreaValue.indexOf("\n\t") !=-1){
		textAreaValue.replace(/\n\t/, "<br>");
	}
	$("textarea").text(textAreaValue);
}

function customizeDialog(){
	$(".ui-dialog-titlebar button").remove();
	$(".ui-dialog-titlebar").html("<img src='../images/icon/dialog_close.png'/>");
	$(".ui-dialog-titlebar img").css("position","absolute");
	$(".ui-dialog-titlebar img").css("right","2px");
	$(".ui-dialog-titlebar img").css("height","17px");
	$(".ui-dialog-titlebar img").css("width","17px");
	$(".ui-dialog-titlebar img").css("cursor","pointer");
	$(".ui-dialog-titlebar img").live('click',function(){
		DIALOG.dialog('close');
    });
}

function initialCurrentMenuItem(id)
{
	$("#"+id).addClass("selected");
}