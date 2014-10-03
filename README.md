Users
=========

Puppet users module to menage users from hiera.
Very slightly based on [mthibaut module] and heavily utilizes native puppet
[user] class.

Unlike mthibaut module, this does not have any dependencies and should work with any Puppet >= 3.0 installation or >= 2.7 if hiera is installed.

Unfortunately this module is not supposed to work with Windows.

Installation
---
Place this module inside environment modules directory. That's it.

Basic usage example
------

Module was developed with big infrastructure in mind. Imagine you have top hierarchy hiera file. However this file is included with lowest priority.
In that file you put all users and place them into groups.

```yaml
users_all:
    john:
        ensure: present
        uid: 1056
        groups:
            - wheel
        ssh_key: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZixdbDH2COA4mMJWwXh9mUr6opI0uFWphgSgw7+q4Fb2bv8KcXFrx1xzTfBvcQAk1VeelflfU9tD8PSOQtVy/6ZbCmxRVK4k8fy+MwVWm5qMJKg+wQucmrMbPhRI2X/c0Pu7QiMP2NDRQzqrN5FY0IkP7ftNMKa6XsM1gm4+iSywm/PI8sUp9ZB2rkVa58a7n0cHYr5HJfqrTlbLrFWV9b3nTho6LTawCF17tbHeSwTmN8Wke7Xy9imGr9kijJBrCtvpLwkqtE3EJBqpGScYfu/09S5miJcKTTNaBvzLqp4GK+ExPJ6zD0bClBfke7thiSC8Vx15d9f+J2FNphqJz"
    exgirlfriend:
        ensure: absent
        uid: 1666
    bobby:
        ensure: present
        customhome: true
        shell: "/bin/zsh"

users_admins:
    - bobby

users_programmers:
    - john
```

Inside environment hiera include user groups admins, programmer and exgirlfriend user:

```yaml
users::account:
    - exgirlfriend
users::groupname:
    - admins
    - programmers

classes:
    - users
```

Extra tips
-------

- **managehome** is set to true by default
- **customhome** has following logic, it searches for directory named as user name inside module/users/files and copies it's content to user's home
- **ssh_key** distributes ssh key as a string, if not set distributes default, placed in modules/users/files/default.pub or <username>.pub

No hiera?
---
You can still use this module as following:

```puppet
node /mynode/ {
    $some_users = {
        john => {ensure => "present"},
        bobby => {ensure => "present", managehome => false}
    }
    class { "users": hash => $some_users }
```


[mthibaut module]:https://forge.puppetlabs.com/mthibaut/users/readme
[user]:https://docs.puppetlabs.com/references/3.7.latest/type.html#user
