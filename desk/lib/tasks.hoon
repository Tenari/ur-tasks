/-  *tasks
|%
:: helpers

:: actions
++  create-todo
  |=  [=todo state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  [~ state]
::
++  edit-todo
  |=  [=todo state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  [~ state]
::
++  delete-todo
  |=  [=id state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  [~ state]
::
++  create-chore
  |=  [=chore state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  [~ state]
::
++  edit-chore
  |=  [=chore state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  [~ state]
::
++  delete-chore
  |=  [=id state=state-0 =bowl:gall]
  ^-  (quip card state-0)
  [~ state]
::
--
