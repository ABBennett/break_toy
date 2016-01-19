PrivatePub.subscribe "/messages/new", (data, channel) ->
  alert data.message.body
