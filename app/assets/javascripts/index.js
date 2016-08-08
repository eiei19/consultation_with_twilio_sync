$(function() {
  var _syncMap;
  var _identity;

  var setUpSync = function(token) {
    accessManager = new Twilio.AccessManager(token);
    syncClient = new Twilio.Sync.Client(accessManager);
    syncClient.map("consultation.members").then(function(map) {
      _syncMap = map;
      _syncMap.set(_identity, {status: "Ready"});
      updateMembersView();

      _syncMap.on('itemUpdated', function() {
        updateMembersView();
      });

      _syncMap.on('itemAdded', function() {
        updateMembersView();
      });

      _syncMap.on('itemRemoved', function() {
        updateMembersView();
      });
    });
  };

  var updateMembersView = function() {
    _syncMap.getItems().then(function(page) {
      $("#Members").html("");
      $.each(page.items, function( index, item ) {
        if (item._key != _identity) {
          $("#Members").append('<li><a href="#" data-indentity="' + item._key + '">' + item._key + '（' + item._value.status + '）</a></li>');
        }
      });
    });
  }

  var setUpPhone = function(token) {
    // Twilio.Device.setup(token, {debug: true});
    Twilio.Device.setup(token);

    Twilio.Device.ready(function (device) {
      $("#CallInfo p.log").text("Ready");
    });

    Twilio.Device.connect(function (conn) {
      _syncMap.set(_identity, {status: "Calling"});
      $("#CallInfo p.log").text("Calling");
    });

    Twilio.Device.cancel(function (conn) {
      _syncMap.set(_identity, {status: "Ready"});
      $("#CallInfo p.log").text("Ready");
    });

    Twilio.Device.disconnect(function (conn) {
      _syncMap.set(_identity, {status: "Ready"});
      $("#CallInfo p.log").text("Ready");
    });

    Twilio.Device.incoming(function (conn) {
      _syncMap.set(_identity, {status: "Calling"});
      $("#CallInfo p.log").text("Incoming");
    });

    Twilio.Device.offline(function (device) {
      _syncMap.remove(_identity);
      $("#CallInfo p.log").text("Offline");
    });
  };

  var initWithIdentity = function(identity) {
    _identity = identity;
    $("#CallInfo p.name").text("you are ["+ _identity +"]")
    var gettingSyncToken = $.getJSON("/sync_token", {identity: identity});
    var gettingPhoneToken = $.getJSON("/phone_token", {identity: identity});
    $.when(gettingSyncToken, gettingPhoneToken).done(function (sync, phone) {
      setUpSync(sync[0].token);
      setUpPhone(phone[0].token);
    });
  };

  $("#Accept").click(function() {
    Twilio.Device.activeConnection().accept();
  });

  $("#Disconnect").click(function() {
    Twilio.Device.disconnectAll();
  });

  $("#GoToOnline").click(function() {
    if ($("#Identity").val() != "") {
      initWithIdentity($("#Identity").val());
      $("#IdentityForm").hide();
    }
    return false
  });

  $("#Members").on("click", "a", function() {
    params = {
      "from_client_id": _identity,
      "to_client_id": $(this).data("indentity")
    };
    Twilio.Device.connect(params);
    return false
  });

  $(window).unload(function() {
    if(_identity) {
      console.log(_identity);
      _syncMap.remove(_identity);
    }
  });
});