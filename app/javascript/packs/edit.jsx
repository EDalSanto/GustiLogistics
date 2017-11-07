import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';

const Form = props => (
  <form>
    {alert("form loaded!")}
  </form>
)

Form.defaultProps = {

}

Form.propTypes = {

}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Form />,
    document.body.appendChild(document.createElement('div'))
  )
})
