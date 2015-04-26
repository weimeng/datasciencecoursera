$(document).ready(function () {
  $("a.nextWordSuggest").on("click", function(event) {
    event.preventDefault();
    var currentPhrase = $("#inputString").val();
    var wordToAdd = $(this).children(".shiny-text-output").html();
    var completedPhrase = currentPhrase + " " + wordToAdd;
    
    $("#inputString").val(completedPhrase);
    $("#inputString").change();
  });
  
  $("button#sendMessage").on("click", function(event) {
    event.preventDefault();
    
    var messageToSend = $("#inputString").val();
    
    if (!!messageToSend) {    
      $("#messageWell").append("<p class='sent message'>" + $("#inputString").val() + "</p>");
      $("#inputString").val("");
      $("#inputString").change();
    }
  });
});
