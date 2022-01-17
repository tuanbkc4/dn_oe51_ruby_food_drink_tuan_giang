$(document).ready(function(){
  var token = $( '[name="csrf-token"]' ).attr( 'content' );
  $('.qty').each(function (index, item) {
    $(item).change(function () {
      var id = $(this).attr("name")
      var quantity = $(this).val();
      $.ajax({
        url: "/carts/update_cart/" + id,
        method: "PUT",
        data: {quantity: quantity},
        headers: {'X-CFRS-Token': token}
      })
    })  
  });    
})
