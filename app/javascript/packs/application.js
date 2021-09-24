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
var cart = {}
    $(document).on('click','#view_cart',function(){

    })
    $(document).on('click','.crack_show',function(){
      $.ajax({
        method: 'GET',
        url: '/crack_show',
        data: {company_id: $(this).attr('id')},
        success: function(response){
        
          var str = "";
            for(let i=0;i<response.length;i++){
            var val = 0
            var loc = JSON.parse(localStorage.getItem("cart_val"))
            //console.log(Object.keys(loc))
            //console.log(loc)
            if(loc != null){
          if (loc[response[i]["_id"]["$oid"]] != null){
            val = loc[response[i]["_id"]["$oid"]][0]
            }
            }
               //console.log(val)
                str += `<div id=`+ response[i]["_id"]["$oid"] +` >
                   <h3><span id="code_`+ response[i]["_id"]["$oid"] +`" >`+ response[i]["code"] +`</span> <span id="name_`+response[i]["_id"]["$oid"]  +`" >`+ response[i]['name'] +`</span></h3>
                   <p id="price_`+ response[i]["_id"]["$oid"] +`" >`+ response[i]['price']+`</p>
                   <p>`+ response[i]['type'] +`</p>
                   <p>`+ response[i]['description'] +`</p>
                   <button class="dec" > - </button>
    <input id="display_`+ response[i]["_id"]['$oid'] +`" type="number" value=`+ val +` >
    <button class="inc" > + </button>
    <button class="add_cart" >Add to Cart</button>
                </div>`
              }
              $("#crack_show").html(str);
          },
        error: function(response){
          console.log("error")
          }
      })
    })
    $(document).on('click',".inc",function(){
       let idd = $(this).parent().attr('id')
       $("#display_"+ idd).val(($("#display_"+idd).val()*1)+1)
       
    })
    $(document).on('click',".dec",function(){
       let idd = $(this).parent().attr('id')
       if ($("#display_"+idd).val() > 0){
        $("#display_"+ idd).val(($("#display_"+idd).val()*1)-1)
       }
       console.log($("#display_"+ idd).val())
    })
    $(document).on('click',".add_cart",function(){
      let idd = String($(this).parent().attr('id'))
      let val = $("#display_"+idd).val()
      if (val>=0){
        cart[idd] = [parseInt(val),parseInt($("#price_"+idd).text()),$("#name_"+idd).text()]
      }
      $("#cart").val(JSON.stringify(cart))
      localStorage.setItem("cart_val", JSON.stringify(cart));
      console.log(cart)
    })
  $(document).ready(function(){
    localStorage.setItem("cart_val",null)
  })
  $(document).on("click","#view_cart",function(){
    var loc = JSON.parse(localStorage.getItem("cart_val"))
    var keys = Object.keys(loc)
    var tot_cost = 0
    var str = `<table class='table table-bordered' >
    <thead>
      <tr>
        <th scope="col" >S.no</th>
        <th scope="col" >Name</th>
        <th scope="col" >Price per Item</th>
        <th scope="col" >Quantity</th>
        <th scope="col" >Total Cost</th>
      </tr>
    </thead><tbody>`
    for(var i=0;i<keys.length; i++){

    str += `<tr>
    <td scope="row" >`+ (i+1) +`</td>
    <td>`+ loc[keys[i]][2] +`</td>
    <td>`+ loc[keys[i]][1] +`</td>
    <td>`+ loc[keys[i]][0] +`</td>
    <td>`+ loc[keys[i]][1] * loc[keys[i]][0] +`</td>
    </tr>`
    tot_cost += loc[keys[i]][1] * loc[keys[i]][0]
    }
    str +=`<tr class="table-success" ><td></td><td></td><td></td><td>Total Cost</td><td>`+ tot_cost +`</td></tr></tbody></table><br><label>Name :</label> <input type="text" id="name" ><br><label >Phone Number :</label> <input type="text" id="phone" ><br><label>Address :</label><input type="text" id="address" ><br> <button class="btn btn-success" id="buy" >Buy</button>`
    $("#cart_show").html(str)
  })
  $(document).on('click','#buy',function(){
    var r = confirm("Confirm your order")
    if (r == true){
      $.ajax({
        method: 'POST',
        url: '/order_update',
        data: {name: $("#name").val(), phone: $("#phone").val(), address: $("#address").val() ,cart: JSON.parse(localStorage.getItem('cart_val'))},
        success: function(response){
          //$("#success").html("<h1>Order Confirmed!!</h1>")
          $('html, body').animate({scrollTop: '0px'}, 0);
          $(".alert").addClass("alert-success")
          $(".alert").text("Ordered Successfully")
          let redirect_Page = () => {
        let tID = setTimeout(function () {
            window.location.href = "https://ecommerce.riyasyacub.repl.co/order";
            window.clearTimeout(tID);		// clear time out.
        }, 3000);
    }
          location.href = "https://ecommerce.riyasyacub.repl.co/order"
        },
        error: function(response){
          console.log(error)
        }
    })
  }
  });

