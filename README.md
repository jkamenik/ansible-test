# ansible-test
Playing with Ansible

## Setup

```bash
$ vagrant up
```

## Use

```base
$ vagrant ssh controller
# run your ansible commands as normal
```

### Setting up the slaves

The slaves are only basically setup using vagrant.  The actual setup is done via ansible.

```bash
controller:~ $ ansible-playbook slave.yml
# sets up the slaves
```
