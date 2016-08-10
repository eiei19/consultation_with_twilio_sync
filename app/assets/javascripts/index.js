$(function() {
  var _syncMap;
  var _consultant

  class Consultant {
    constructor(identity, topic) {
      this.identity = identity;
      this.topic = topic;
      this.status = "";
      $.trigger("initConsultant", this);
    }

    changeStatus(status) {
      this.status = status
      _syncMap.set(this.identity, {status: this.status, topic: this.topic});
      $.trigger("changedConsultantStatus", this);
    }

    goToOffline() {
      _syncMap.remove(this.identity);
    }
  }

  $.one("initConsultant", function (e, consultant) {
    $("p#UserInfo").text(consultant.identity+": "+consultant.topic);
    $("p#UserInfo").show();
    $("#CallOperations").show();
  });

  $.on("changedConsultantStatus", function (e, consultant) {
    $("p#UserStatus").text(consultant.status);
    $("p#UserStatus").show();
  });

  var setUpSync = function(token) {
    accessManager = new Twilio.AccessManager(token);
    syncClient = new Twilio.Sync.Client(accessManager);
    syncClient.map("consultation.members").then(function(map) {
      _syncMap = map;
      _consultant.changeStatus("待受中");
      updateOnlineConsultantsView();
      $.each(["itemUpdated", "itemAdded", "itemRemoved"], function(index, action) {
        _syncMap.on(action, function() {
          updateOnlineConsultantsView();
        });
      });
    });
  };

  var setUpPhone = function(token) {
    Twilio.Device.setup(token);

    Twilio.Device.ready(function (device) {
      _consultant.changeStatus("待受中");
    });

    Twilio.Device.connect(function (conn) {
      _consultant.changeStatus("通話中");
    });

    Twilio.Device.cancel(function (conn) {
      _consultant.changeStatus("待受中");
    });

    Twilio.Device.disconnect(function (conn) {
      _consultant.changeStatus("待受中");
    });

    Twilio.Device.incoming(function (conn) {
      _consultant.changeStatus("入電中");
    });

    Twilio.Device.offline(function (device) {
      _consultant.goToOffline();
    });

    $("#Accept").click(function() {
      Twilio.Device.activeConnection().accept();
    });

    $("#Disconnect").click(function() {
      Twilio.Device.disconnectAll();
    });

    $("#OnlineConsultants").on("click", "a", function() {
      params = {
        "from_client_id": _consultant.identity,
        "to_client_id": $(this).data("indentity")
      };
      Twilio.Device.connect(params);
      return false
    });
  };

  var updateOnlineConsultantsView = function() {
    _syncMap.getItems().then(function(page) {
      $("#OnlineConsultants").html("");
      $.each(page.items, function(index, item) {
        if (item._key != _consultant.identity) {
          $("#OnlineConsultants").append('<li><a href="#" data-indentity="' + item._key + '">' + item._key + ': ' + item._value.topic + ' / ' + item._value.status + '</a></li>');
        }
      });
    });
  };

  var goToOnline = function(identity, topic) {
    _consultant = new Consultant(identity, topic)
    var gettingSyncToken = $.getJSON("/sync_token", {identity: identity});
    var gettingPhoneToken = $.getJSON("/phone_token", {identity: identity});
    $.when(gettingSyncToken, gettingPhoneToken).done(function (sync, phone) {
      setUpSync(sync[0].token);
      setUpPhone(phone[0].token);
    });
  };

  $("#GoToOnline").click(function() {
    if ($("#Identity").val() != "") {
      goToOnline($("#Identity").val(), $("#Topic").val());
      $("#IdentityForm").hide();
    }
    return false
  });

  $(window).unload(function() {
    if(_consultant) {
      _syncMap.remove(_consultant.identity);
    }
  });
});