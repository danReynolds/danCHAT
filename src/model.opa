type message = {
  string author, /** The name of the author (arbitrary string) */
  string text  /** Content entered by the user */
}

module Model {

  private Network.network(message) room = Network.cloud("room")

  exposed function broadcast(message) {
    Network.broadcast(message, room);
  }

  function register_message_callback(callback) {
    Network.add_callback(callback, room);
  }
}

function user_update(message msg) {
  line = <div class="row line">
            <div class="span1 userpic" />
            <div class="span2 user">{msg.author}:</>
            <div class="span9 message">{msg.text}</>
          </div>;
  #conversation =+ line;
  Dom.scroll_to_bottom(#conversation);
}

function user_welcome() {
  line = <div class = "row line name">
            <div class="span1 userpic" />
            <div class="span2 user">Admin</>
            <div class="span9" >
              <input id=#name class=input-xxlarge type=text placeholder="Welcome! Enter your name..." 
                onnewline={function(_) { setup_user(Dom.get_value(#name)) }}>
            </div>
        </div>;
  #conversation =+ line;
}

function setup_user(author) {

  user_update({text: "Welcome, {author}", author: "Admin"}); 
  Dom.remove(Dom.select_class("name"));
  broadcast_joined(author);

  line = <div> <input id=#entry class=input-xxlarge type=text
            onnewline={function(_) { broadcast(author) }}>
         <button class="btn btn-primary" type=button
            onclick={function(_) { broadcast(author) }}>Post</> </div>;

  #user_input =+ line;
}

function broadcast(author) {
  text = Dom.get_value(#entry);
  Model.broadcast(~{author, text});
  Dom.clear_value(#entry);
}

function broadcast_joined(author) {
  text = "{author} has joined the room"
  author = "Admin"
  Model.broadcast(~{author, text});
}

