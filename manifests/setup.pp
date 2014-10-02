define users::setup($allowdupe=undef, $attribute_membership=undef, $attributes=undef,
    $auth_membership=undef, $auths=undef, $comment=undef, $ensure=undef, $expiry=undef,
    $gid=undef, $groups=undef, $home="/home/$name", $ia_load_module=undef,
    $key_membership=undef, $keys=undef, $managehome=true,
    $membership=undef, $password=undef, $password_max_age=undef,
    $password_min_age=undef, $profile_membership=undef, $profiles=undef,
    $project=undef, $provider=undef, $role_membership=undef,
    $roles=undef, $shell=undef, $system=undef, $uid=undef, $customhome=false,
    $ssh_key=undef) {
    if(!defined(User[$name])) {
        user { $name :
                allowdupe => $allowdupe,
                attribute_membership => $attribute_membership,
                attributes => $attributes,
                auth_membership => $auth_membership,
                auths => $auths,
                comment => $comment,
                ensure => $ensure,
                expiry => $expiry,
                gid => $gid,
                groups => $groups,
                home => $home,
                ia_load_module => $ia_load_module,
                key_membership => $key_membership,
                keys => $keys,
                managehome => $managehome,
                membership => $membership,
                password => $password,
                password_max_age => $password_max_age,
                password_min_age => $password_min_age,
                profile_membership => $profile_membership,
                profiles => $profiles,
                project => $project,
                provider => $provider,
                role_membership => $role_membership,
                roles => $roles,
                shell => $shell,
                system => $system,
                uid => $uid,
        }
        if ($managehome != false) {
            if (!$gid) {
                $group = $name
            } else {
                $group = $gid
            }
            if ($customhome) {
                users::custom_home { "${name}_customhome":
                    user    => $name,
                    home    => $home,
                    group   => $group,
                }
            } else {
                if ($ensure == "present") {
                    users::ssh_authorized_keys { "${name}_ssh_authorized_keys":
                        user    => $name,
                        home    => $home,
                        group   => $group,
                        ssh_key => $ssh_key,
                    }
                }
            }
        }
    }
}
