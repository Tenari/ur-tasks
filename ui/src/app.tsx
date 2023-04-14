import React, { useEffect, useState } from 'react';
import Urbit from '@urbit/http-api';
import Tome from '@holium/tome-db';
import {styles} from './assets/style_config';

const api = new Urbit('', '', window.desk);
api.ship = window.ship;
window.api = api;

const db = await Tome.init(api, 'tasks', {
    realm: true
})
const kv = await db.keyvalue({
    bucket: 'tasks',
    permissions: { read: 'open', write: 'space', admin: 'our' },
    preload: false,
})

export function App() {
  const [page, setPage] = useState('root');
  const [newTask, setNewTask] = useState({});
  const [tasks, setTasks] = useState([]);
  const [adding, setAdding] = useState(false);

  useEffect(() => {
    async function init() {
      const tasks = await kv.get('tasks');
      console.log(tasks);
      if (tasks) {
        setTasks(tasks);
      } else {
        await kv.set('tasks', []);
      }
    }

    init();
  }, []);

  console.log('state tasks', tasks);

  const createTask = async () => {
    let temp = JSON.parse(JSON.stringify(newTask));
    temp.completed = false;
    await kv.set('tasks', [...tasks, temp]);
    setTasks(await kv.get('tasks'));
    setNewTask({});
    setAdding(false);
  };

  const complete = async (e,i) => {
    let temp = JSON.parse(JSON.stringify(tasks[i]));
    temp.completed = e.target.checked;
    let arr = [...tasks];
    arr[i] = temp;
    await kv.set('tasks', arr);
    setTasks(await kv.get('tasks'));
  };

  return (
    <main className="bg-gray-400">
      <button className={styles.smbtn + styles.goodMehFn(!adding)} onClick={() => setAdding(!adding)}>Add task</button>
      {adding && <div className={styles.container}>
        <div>
          Name: <input type="text" className={styles.textinput} value={newTask.name} onChange={(e) => setNewTask({...newTask, name: e.target.value})} />
        </div>
        <div>
          Type:
          <select value={newTask.type} onChange={(e) => setNewTask({...newTask, type: e.target.value})}>
            <option value="todo">Single To-Do</option>
            <option value="recur">Recurring</option>
          </select>
        </div>
        {newTask.type === 'recur' && <div>
          Recur every <input type="number" value={newTask.recurNumber} onChange={(e) => setNewTask({...newTask, recurNumber: e.target.value})} />
          <select value={newTask.recurPeriod} onChange={(e) => setNewTask({...newTask, recurPeriod: e.target.value})}>
            <option value="day">Day</option>
            <option value="week">Week</option>
          </select>
          <br />
          Starting at (urbit @da string) <input className={styles.textinput} type="text" value={newTask.recurStart} onChange={(e) => setNewTask({...newTask, recurStart: e.target.value})} />
        </div>}
        <button className={styles.smbtn + 'bg-green-200'} onClick={createTask}>Create</button>
      </div>}
      <ul>
        {tasks.map( (t,i) => {
          return <li key={i}>
            <input type="checkbox" checked={t.completed} onChange={(e) => complete(e,i)}/> {t.name}
          </li>;
        })}
      </ul>
    </main>
  );
}
