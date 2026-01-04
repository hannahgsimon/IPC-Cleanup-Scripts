# IPC Cleanup Scripts (System V)

Lightweight shell utilities to remove System V IPC resources owned by the current user. Useful for debugging and development when cleaning up leftover semaphores, message queues, or shared memory segments.

## 📁 Included Scripts
```bash
.
├── clean.bash            # Bash: remove queues/semaphores/shm (supports flags)
└── clean.ksh             # KornShell: remove all semaphores for current user
```

## ✅ Requirements
- Linux / WSL
- `ipcs` and `ipcrm` available (typically from `util-linux`)

⚠️ Safety Note: These scripts delete IPC objects (owned by your user). Use them only when you’re sure you want to remove those resources.

## 🧪 Usage
1) Make executable
```bash
chmod +x clean.bash clean.ksh
```

2) Bash script: `clean.bash`
Removes IPC facilities by type:
```bash
./clean.bash -q   # remove message queues
./clean.bash -s   # remove semaphores
./clean.bash -m   # remove shared memory segments
./clean.bash -a   # remove all of the above
```

3) KornShell script: `clean.ksh`
Removes all semaphores owned by the current user:
```bash
./clean.ksh
```

## 🔎 Verify (optional)
Before/after cleanup, you can inspect what exists:
```bash
ipcs -q   # queues
ipcs -s   # semaphores
ipcs -m   # shared memory
```

---

## 📜 License

This project is licensed under the MIT License. See the LICENSE file for details.

---

## 👤 Author
Hannah G. Simon
