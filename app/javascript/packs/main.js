document.addEventListener('turbolinks:load', () => {
  localStorage.setItem('theme', (localStorage.getItem('theme') || 'light') === 'light' ? 'light' : 'dark');
  
  const switchButton = document.getElementById('themeSwitch');
  if (localStorage.getItem('theme') === 'dark') {
    document.querySelector('body').setAttribute('data-theme', 'dark')
    switchButton.checked = true;
  } else {
    document.querySelector('body').removeAttribute('data-theme');
  }

  switchButton.addEventListener('change', function (event) {
    if (event.target.checked) {
      document.body.setAttribute('data-theme', 'dark');
      localStorage.setItem('theme', 'dark');
    } else {
      document.body.removeAttribute('data-theme');
      localStorage.setItem('theme', 'light');
    }
  });
})