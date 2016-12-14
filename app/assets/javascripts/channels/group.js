App.group = App.cable.subscriptions.create("GroupChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var group = $('#groups-list').find("[data-group-id='" + data['group_id'] + "']");

    if (data['window'] !== undefined) {
      var group_visible = group.is(':visible');

      if (group_visible) {
        var messages_visible = (group).find('.panel-body').is(':visible');

        if (!messages_visible) {
          group.removeClass('panel-default').addClass('panel-success');
        }
        group.find('.messages-list').find('ul').append(data['message']);
      }
      else {
        $('#groups-list').append(data['window']);
        group = $('#groups-list').find("[data-group-id='" + data['group_id'] + "']");
        group.find('.panel-body').toggle();
      }
    }
    else {
      group.find('ul').append(data['message']);
    }

    var messages_list = group.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },
  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});

$(document).on('submit', '.new_group_message', function(e){
  e.preventDefault();
  var values = $(this).serializeArray();
  App.group.speak(values);
  $(this).trigger('reset');
});

