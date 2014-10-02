define users::ssh_authorized_keys($user, $home, $group, $ssh_key=undef) {

    if(!defined(Ssh_authorized_keys[$user])) {
        file { "$home/.ssh":
            ensure  => directory,
            owner   => $user,
            group   => $group,
            mode    => 700
        }
        if $ssh_key {
            file { "$home/.ssh/authorized_keys":
                ensure  => present,
                content => $ssh_key,
                mode    => 600,
                owner   => $user,
                group   => $group
            }
        } else {
            file { "$home/.ssh/authorized_keys":
                ensure  => present,
                source  => ["puppet:///modules/users/$user.pub", "puppet:///modules/users/$user/.ssh/authorized_keys", "puppet:///modules/users/default.pub"],
                mode    => 600,
                owner   => $user,
                group   => $group
            }
        }
   }
}
