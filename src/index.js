const { app, BrowserWindow, nativeImage, Menu} = require('electron');
const path = require('path');
const url = require('url');
var win;
app.on('ready', function () {
  win = new BrowserWindow({
    minWidth: 350,
    minHeight: 340,
    title: 'Calculator',
    backgroundColor: '#eee',
    autoHideMenuBar: true,
    frame: true,
    icon: nativeImage.createFromPath(path.join(__dirname, 'icons/64.png')),
    show: false
  })
  win.loadURL(url.format({
    pathname: path.join(__dirname, 'Calc.html'),
    protocol: 'file:',
    slashes: true
  }))
  Menu.setApplicationMenu(Menu.buildFromTemplate([
    {
    label: 'Edit',
    submenu: [
      {role: 'undo'},
      {role: 'redo'},
      {type: 'separator'},
      {role: 'cut'},
      {role: 'copy'},
      {role: 'paste'},
      {role: 'pasteandmatchstyle'},
      {role: 'delete'},
      {role: 'selectall'}
    ]
  },
  {
    label: 'View',
    submenu: [
      {role: 'reload'},
      {role: 'forcereload'},
      {type: 'separator'},
      {role: 'resetzoom'},
      {role: 'zoomin'},
      {role: 'zoomout'},
    ]
  },
  {
    role: 'Window',
    submenu: [
      {role: 'minimize'},
      {role: 'close'}
    ]
  }
  ]))
  win.once('ready-to-show', function(){
    win.show();
  })
  win.on('closed', function(){
    win = null;
    app.quit();
  })
})