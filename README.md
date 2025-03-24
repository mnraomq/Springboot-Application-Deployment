# Springboot-Application-Deployment
1.Check If We Have Any SSH Keys under (ls -la ~/.ssh)
2.If we have keys already, it will show "id_rsa and id_rsa.pub"
3.If no keys, generate a new ssh keys (ssh-keygen -t rsa -b 4096 -C "your-email@example.com")
4.Add ssh key to ssh agent (start ssh agent and add ssh eky)
5.Add ssh public key to github under ssh and gpg keys
6.Test ssh connection using "ssh -T git@github.com" and clone repo if test succeed "git clone <SSH-URL>"

