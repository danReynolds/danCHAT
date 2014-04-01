module View {

   // View code goes here

  function page_template(content) {
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class=navbar-inner>
        <div class=container>
          <div id=#logo />
        </div>
      </div>
    </div>
    <div id=#main>
      {content}
    </div>
  }

  function chat_html() {
    <div id=#conversation class=container-fluid
      onready={function(_) { 
        Model.register_message_callback(user_update)
        user_welcome()
      } } />
    <div id=#footer class="navbar navbar-fixed-bottom">
      <div class=container>
        <div id=#user_input>
        </div>
      </div>
    </div>
  }

  function default_page() {
    Resource.page("DanCHAT", page_template(chat_html()));
  }

}
