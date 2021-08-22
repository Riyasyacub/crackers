// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


// require("@rails/ujs").start()
Rails.start()
Turbolinks.start()
ActiveStorage.start()
require("jquery")

$(document).ready(function(){
  $("#add_tag").click(function(){
    $(this).hide();
    
    $("#show_tag").show();
  });
  
  // $("#create_tag").click(function(){
  //   console.log("hello")
  // })
  $("#create_tag").on('click',function(e){
    console.log("ajax")
    $.ajax({
      method: 'GET',
      url: '../../tags/new',
      data: {name: $("#tag_name").val()},
      success: function(response){
        console.log(response)
        $("#show_tag").hide()
        $("#select").append(new Option(response['name'],response['_id']['$oid']))
        $("#add_tag").show()
      },
      error: function(response){
        console.log("error");
      }
    })
  })
});

