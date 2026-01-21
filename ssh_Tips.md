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

10. Forwarding agent from PC to the remote machine -
    - Allow agent forwarding on the host machine -
        ```bash
        sudo nano /etc/ssh/sshd_config
        ```
    - Uncomment following line -
        ```bash
        AllowAgentForwarding yes
        ```
    - Restart the ssh service -
        ```bash
        sudo systemctl restart ssh
        ```
    - Verify forwarding is actually working on the remote machine, run following command on your pc
        ```bash
        ssh -A pi@192.168.1.50
        ```
    - On the host machine run -
        ```bash
        echo $SSH_AUTH_SOCK
        ```
    - Now check whether the remote machine can “see” your forwarded keys:
        ```bash
        ssh-add -L
        ```
        You should see your public key(s) listed.