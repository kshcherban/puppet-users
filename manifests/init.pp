class users(
    $hash       = undef,
    $groupname  = undef,
    $account    = undef,
) {

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
