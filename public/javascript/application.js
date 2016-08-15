$(document).ready(function() {

      $('#map_form').submit(function(ev){
   
        ev.preventDefault();

        $.ajax({
          method: "POST",
          url: "/listings/map",
          data: $(this).serialize(),
      
          success: function(data) {
            $("#map").googleMap({
                    coords: [49.2827, -123.1207],
                    zoom: 12
                  });
            for (var i = 0; i < data.listings.length; i++) {
              for (var list in data.listings[i]) {

                  $("#map").addMarker({
                    coords: [
                      data.listings[i].latitude, 
                      data.listings[i].longitude],
                    title: data.listings[i].street_address,
                    text: '<p>Price: $' + data.listings[i].price  +' monthly</p> <p>Area:'+ data.listings[i].area +' square feet</p>'
                    
                  });
              }
               // var list = data.listings[i];
            }
         } ,
         error: function(){
            alert('Error on loading');
        }
        });  

      });
});



