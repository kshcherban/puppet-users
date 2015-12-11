define users::create_group {
    $users = hiera("users_${name}", undef)
    if $users {
        users::create_user { $users: }
    }
    else {
        notify { "no data for resource ${name}": }
    }
}
