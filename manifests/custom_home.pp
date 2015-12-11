define users::custom_home($user, $group, $home) {
    if(!defined(Custom_home[$user])) {
        file { "$home":
            ensure  => directory,
            owner   => $user,
            group   => $group,
            mode    => '0600',
            recurse => remote,
            source  => "puppet:///modules/users/$user"
        }
    }
}
