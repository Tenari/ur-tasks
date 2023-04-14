/-  *tasks
/+  default-agent, dbug, lib=tasks

%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
++  on-init
  ^-  (quip card _this)
  `this
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  =.  state   *state-0
  ::`this(state !<(state-0 old))
  `this(state state)
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  =(%tasks-action mark)
  =/  act  !<(action vase)
  ?>  =(our.bowl src.bowl)
  =^  cards  state
  ?-  -.act :: each handler needs to return a list of cards and a new state
    %create-todo
      (create-todo:lib +.act state bowl)
    %edit-todo
      (edit-todo:lib +.act state bowl)
    %delete-todo
      (delete-todo:lib +.act state bowl)
    %create-chore
      (create-chore:lib +.act state bowl)
    %edit-chore
      (edit-chore:lib +.act state bowl)
    %delete-chore
      (delete-chore:lib +.act state bowl)
  ==
  [cards this]
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+  path  (on-peek:default path)
    [%x %todos ~]
      ``todos+!>(todos)
    [%x %chores ~]
      ``chores+!>(chores)
    [%x %todos %since @ ~]
      =/  timestamp=@da   (di:dejs:format n+i.t.t.t.path)
      ``todos+!>(todos)
    [%x %chores %since @ ~]
      =/  timestamp=@da   (di:dejs:format n+i.t.t.t.path)
      ``chores+!>(chores)
    [%x %todos %space *]
      =/  thepath  t.t.t.path
      ``todos+!>((lot:todon todos `[`@t`+(`@`(spat thepath)) `@da`0] `[(spat thepath) `@da`0]))
    [%x %chores %space *]
      =/  thepath  t.t.t.path
      ``chores+!>((lot:choron chores `[`@t`+(`@`(spat thepath)) `@da`0] `[(spat thepath) `@da`0]))
  ==
++  on-arvo   on-arvo:default
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:default path)
    [%http-response *]
      `this
  ==
++  on-leave  on-leave:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
