import ReactDOM from 'react-dom';
import React from 'react';


//    <%= form_for(:session, url: login_path) do |f| %>
//
//      <%= f.label :email %>
//      <%= f.email_field :email, class: 'form-control' %>
//
//      <%= f.label :password %>
//      <%= f.password_field :password, class: 'form-control' %>
//
//      <%= f.submit "Log in", class: "btn btn-primary" %>
//    <% end %>

class Login extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      token: localStorage.getItem("token"),
      email: '',
      password: ''
    }
  }

  onEmailChange(e) {
    this.setState({
      email: e.target.value
    });
  }

  onPasswordChange(e) {
    this.setState({
      password: e.target.value
    });
  }

  render() {
    return(
      <div>
        <h1>Log in</h1>
        <div className="row">
          <div className="col-md-6 col-md-offset-3">
            <label>
              Email
              <input
                value={this.state.email}
                className="form-control"
                onChange={this.onEmailChange.bind(this)}
              />
            </label>
            <label>
              Password
              <input
                value={this.state.password}
                className="form-control"
                onChange={this.onPasswordChange.bind(this)}
              />
            </label>
            <input
              type="submit"
              value="Log in"
              className="btn btn-primary"
            />
          </div>
        </div>
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Login />,
    document.getElementById('log-in')
  )
});
