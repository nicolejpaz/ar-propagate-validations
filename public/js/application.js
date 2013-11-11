$(document).ready(function() {
  // This function is called after the DOM has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  // send an HTTP DELETE request for the sign-out link
  $('a#sign-out').on("click", function (e) {
    e.preventDefault();
    var request = $.ajax({ url: $(this).attr('href'), type: 'delete' });
    request.done(function () { window.location = "/"; });
  });

  $('form').on('submit', function(e) {
    e.preventDefault()
    var form_data = $(this).serialize()

    $.ajax({
      url: '/events/create',
      type: 'post',
      data: form_data
    }).done(function(server_data) {
      var parsed_data = $.parseJSON(server_data)

      $('div#new_event').html(parsed_data['title'] + '<br>' + parsed_data['organizer_name'] + '<br>' + parsed_data['organizer_email'] + '<br>' + parsed_data['date'])

    }).fail(function() {
      console.log('failed!')
    })
  })
});
