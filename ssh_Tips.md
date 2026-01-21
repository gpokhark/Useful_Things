# SSH Quick Reference

1. Start SSH agent
   ```bash
   eval "$(ssh-agent -s)"
   ```

2. Add private key

    ```bash
    ssh-add ~/.ssh/id_ed25519
    ```
3. List loaded keys
    ```bash
    ssh-add -l    # fingerprints
    ssh-add -L    # public keys
    ```
4. Copy public key to remote host

    ```bash
    ssh-copy-id -i ~/.ssh/id_ed25519.pub pi@192.168.1.100
    ```

5. Connect using a specific key

    ```bash
    ssh -i ~/.ssh/id_ed25519 pi@192.168.1.50
    ```

6. Configure SSH host

    ```bash
    Host pi1
      HostName 192.168.1.50
      User pi
      IdentityFile ~/.ssh/id_ed25519
      ForwardAgent yes
    ```

7. Verify key usage
    ```bash
    ssh -T git@github.com
    ssh -v pi1
    ```

8. Generate a new key

    ```bash
    ssh-keygen -t ed25519 -C "your_email@example.com"
    ```

9. Remove a known host
    - Manually delete the entry from ~/.ssh/known_hosts
    - Or run:
        ```bash
        ssh-keygen -R 192.168.1.50
        ```
