|%
:: meta-data types
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
      =chores
      =todos
      =del-log
  ==
::  fundamental data types
+$  metadata  (map cord cord)
+$  id        [space=cord t=@da]  :: space is the cord-ified space-path where the task lives, t is just the timestamp
::  2 bits of info in a id:
::  order by space first
::  then timestamp
++  id-sort
  |=  [a=id b=id]
  ?:  =(space.a space.b)
    :: same space, so order by timestamp
    (gth t.a t.b)
  :: else just order by space
  (gth space.a space.b)
::
:: a `chore` recurs on some schedule
:: a `todo` is a one-off task
:: these are the two fundamental units of data here
::
+$  todo
  $:
    =id
    title=@t
    description=@t
    assigned-to=(set ship)
    comments=path  :: the chat-db path where comments are kept
    due-date=@da
    completed=?
    completed-at=@da
    updated-at=@da
    =metadata
  ==
+$  todos     ((mop id todo) id-sort)
++  todon     ((on id todo) id-sort)
+$  chore
  $:
    =id
    title=@t
    description=@t
    start=@da
    end=@da
    interval=@dr
    assigned-to=(set ship)
    comments=path  :: the chat-db path where comments are kept
    logs=(set @da) :: the times when this was done
    updated-at=@da
    =metadata
  ==
+$  chores    ((mop id chore) id-sort)
++  choron    ((on id chore) id-sort)

+$  del-log   ((mop time db-change-type) gth)
++  delon     ((on time db-change-type) gth)


:: external interface types
+$  db-change-type
  $%
    [%add-todo =todo]
    [%upd-todo =todo]
    [%del-todo =id]

    [%add-chore =chore]
    [%upd-chore =chore]
    [%del-chore =id]
  ==
+$  action
  $% 
    [%create-todo =todo]
    [%edit-todo =todo]
    [%delete-todo =id]

    [%create-chore =chore]
    [%edit-chore =chore]
    [%delete-chore =id]
  ==
--
