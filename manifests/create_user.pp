define users::create_user {
    $all_users = hiera('users_all')
    if $all_users[$name] {
        $u_hash = { "$name" => $all_users[$name] }
        create_resources(users::setup, $u_hash)
    } else {
        notify { "no data for resource ${name}": }
    }
}
