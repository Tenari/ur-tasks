/-  *tasks
|%
++  dejs
  =,  dejs:format
  |%
  ++  action
    |=  jon=json
    ^-  ^action
    =<  (decode jon)
    |%
    ++  decode
      %-  of
      :~  [%create-todo de-todo]
          [%edit-todo de-todo]
          [%delete-todo de-id]
          [%create-chore de-chore]
          [%edit-chore de-chore]
          [%delete-chore de-id]
      ==
    ::
    ++  de-chore
      %-  ot
      :~  [%id de-id]
          [%title so]
          [%description so]
          [%start di]
          [%end di]
          [%interval null-or-dri]
          [%assigned-to (as (se %p))]
          [%comments pa]
          [%logs (as di)]
          [%updated-at di]
          [%metadata (om so)]
      ==
    ::
    ++  de-todo
      %-  ot
      :~  [%id de-id]
          [%title so]
          [%description so]
          [%assigned-to (as (se %p))]
          [%comments pa]
          [%due-date di]
          [%completed bo]
          [%completed-at null-or-di]
          [%updated-at null-or-di]
          [%metadata (om so)]
      ==
    ::
    ++  de-id
      %+  cu
        path-to-id
      pa
    ::
    ++  path-to-id
      |=  p=path
      ^-  id
      [(spat [+2:p +6:p ~]) `@da`(slav %da +14:p)]
    ::
    ::
    ++  dri   :: specify in integer milliseconds, returns a @dr
      (cu |=(t=@ud ^-(@dr (div (mul ~s1 t) 1.000))) ni)
    ::
    ++  null-or-dri   :: specify in integer milliseconds, returns a @dr
      (cu |=(t=@ud ^-(@dr (div (mul ~s1 t) 1.000))) null-or-ni)
    ::
    ++  null-or-di   :: specify in integer milliseconds, returns a @da
      (cu |=(t=@ud ^-(@da ?:(=(0 t) *@da (from-unix-ms:chrono:userlib t)))) null-or-ni)
    ::
    ++  null-or-ni  :: accepts either a null or a n+'123', and converts nulls to 0, non-null to the appropriate number
      |=  jon=json
      ^-  @ud
      ?+  jon  !!
        [%n *]  (rash p.jon dem)
        ~       0
      ==
    ::
    --
  --
++  encode
  =,  enjs:format
  |%
    ::
    ++  en-todos
      |=  =todos
      ^-  json
      :-  %a
      %+  turn  (tap:todon todos)
        |=  [=id =todo]
        ^-  json
        %-  pairs
        :~  id+(en-id id)
            title+s+title.todo
            description+s+description.todo
            ::assigned-to+(
        ==
    ::
    ++  en-chores
      |=  =chores
      ^-  json
      :-  %a
      %+  turn  (tap:choron chores)
        |=  [=id =chore]
        ^-  json
        %-  pairs
        :~  id+(en-id id)
            title+s+title.todo
            description+s+description.todo
            ::assigned-to+(
        ==
    ::
    ++  en-id
      |=  =id
      ^-  json
      s+(spat [space.id (scot %da t.id) ~])
    ::
    ++  numbrd
      |=  a=@rd
      ^-  json
      :-  %n
      (crip (flop (snip (snip (flop (trip (scot %rd a)))))))
    --
--
