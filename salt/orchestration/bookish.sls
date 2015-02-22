bookish_highstate:
  salt.state:
    - tgt: 'bookish*'
    - highstate: True
