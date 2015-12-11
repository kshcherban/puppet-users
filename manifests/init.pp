class users(
    $hash       = undef,
    $groupname  = undef,
    $account    = undef,
) {
# Create users for each passed name
    define users::create_user {
        $all_users = hiera('users_all')
        if $all_users[$name] {
            $u_hash = { "$name" => $all_users[$name] }
            create_resources(users::setup, $u_hash)
        } else {
            notify { "no data for resource '$name' title '$title'": }
        }
    }
# Create users for each passed group
    define users::create_group {
        $users = hiera("users_$name", undef)
        if $users {
            users::create_user { $users: }
        }
        else {
            notify { "no data for resource '$name' title '$title'": }
        }
    }

    if $account {
        users::create_user { $account: }
    }
    if $groupname {
        users::create_group { $groupname: }
    }
    if $hash {
        create_resources(users::setup, $hash)
    }
}
