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
  
  
  // $("#create_tag").click(function(){
  //   console.log("hello")
  // })
  $("#cmp").on('change',function(e){
    // console.log("ajax")
    $.ajax({
      method: 'GET',
      url: '/crck_fetch',
      data: {company: $("#cmp").val()},
      success: function(response){
        console.log(response)
        // $("#show_tag").hide()
        for (var i=0;i<response.length;i++){
          $("#crck").append(new Option(response[i][0], response[i][1]["$oid"]))
        }
        $("#crck").prop("disabled",false)
        // $("#add_tag").show()
      },
      error: function(response){
        console.log("error");
      }
    })
  })
});

