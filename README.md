# Springboot-Application-Deployment

Steps for SSH key generation & add to github:
---------------------------------------------

1.Check if we have any ssh keys under (ls -la ~/.ssh)


2.If we have keys already, it will show "id_rsa and id_rsa.pub"


3.If no keys, generate a new ssh keys (ssh-keygen -t rsa -b 4096 -C "your-email@example.com")


4.Add ssh key to ssh agent (start ssh agent and add ssh key)


5.Add ssh public key to github under ssh and gpg keys


6.Test ssh connection using "ssh -T git@github.com" and clone repo if test succeed "git clone <SSH-URL>"

---------------------------------------------------------------------------------------------------------

Steps for creating feature branch and merge into main:
------------------------------------------------------

1.Switch to main branch and create new feature branch in local git (git branch <branch-name>


2.Switch to feature branch and do changes/fixes (git checkout <feature branch name>)


3.Add changes to staging directory (git add . & git commit -m "note as per change")


4.Now push feature branch to remote to raise pull request (git push origin <feature branch name>)


5.Go to github and raise pull request, once pull request review and approved, then merge feature branch changes into main branch.


6.Once merged, again pull the main branch into local for upto date.


7.Now can delete the feature branch if needed to maintain upto date branches (git branch -d <feature branch name>)

---------------------------------------------------------------------------------------------------------

changes for validating webhook triggering process

updated feature-fix branch


