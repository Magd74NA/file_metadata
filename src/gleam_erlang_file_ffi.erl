-module(gleam_erlang_file_ffi).
-include_lib("file.hrl").
-export([file_info/1]).


%% A macro for checking whether the error returned is one of the atoms for a posixe error.
-define(is_posix_error(Error),
        Error =:= eacces
        orelse Error =:= eagain
        orelse Error =:= ebadf
        orelse Error =:= ebadmsg
        orelse Error =:= ebusy
        orelse Error =:= edeadlk
        orelse Error =:= edeadlock
        orelse Error =:= edquot
        orelse Error =:= eexist
        orelse Error =:= efault
        orelse Error =:= efbig
        orelse Error =:= eftype
        orelse Error =:= eintr
        orelse Error =:= einval
        orelse Error =:= eio
        orelse Error =:= eisdir
        orelse Error =:= eloop
        orelse Error =:= emfile
        orelse Error =:= emlink
        orelse Error =:= emultihop
        orelse Error =:= enametoolong
        orelse Error =:= enfile
        orelse Error =:= enobufs
        orelse Error =:= enodev
        orelse Error =:= enolck
        orelse Error =:= enolink
        orelse Error =:= enoent
        orelse Error =:= enomem
        orelse Error =:= enospc
        orelse Error =:= enosr
        orelse Error =:= enostr
        orelse Error =:= enosys
        orelse Error =:= enotblk
        orelse Error =:= enotdir
        orelse Error =:= enotsup
        orelse Error =:= enxio
        orelse Error =:= eopnotsupp
        orelse Error =:= eoverflow
        orelse Error =:= eperm
        orelse Error =:= epipe
        orelse Error =:= erange
        orelse Error =:= erofs
        orelse Error =:= espipe
        orelse Error =:= esrch
        orelse Error =:= estale
        orelse Error =:= etxtbsy
        orelse Error =:= exdev).

-type file_info() ::
    {file_info,
     integer(),
     integer(),
     integer(),
     integer(),
     integer(),
     integer(),
     integer(),
     integer(),
     integer(),
     integer()}.
-type file_error() ::
    eacces | eagain | ebadf | ebadmsg | ebusy | edeadlk | edeadlock | edquot | eexist |
    efault | efbig | eftype | eintr | einval | eio | eisdir | eloop | emfile | emlink |
    emultihop | enametoolong | enfile | enobufs | enodev | enolck | enolink | enoent |
    enomem | enospc | enosr | enostr | enosys | enotblk | enotdir | enotsup | enxio |
    eopnotsupp | eoverflow | eperm | epipe | erange | erofs | espipe | esrch | estale |
    etxtbsy | exdev | not_utf8 | {unknown, binary()}.

-spec file_info(binary()) -> {ok, file_info()} | {error, file_error()}.
file_info(Filename) ->
    file_info_result(file:read_file_info(Filename, [{time, posix}])).

    file_info_result(Result) ->
        case Result of
            {ok,
             #file_info{
              size = Size,
              type = _Type,
              access = _Access,
              atime = Atime,
              mtime = Mtime,
              ctime = Ctime,
              mode = Mode,
              links = Links,
              major_device = MajorDevice,
              minor_device = _MinorDevice,
              inode = Inode,
              uid = Uid,
              gid = Gid}} ->
                {ok, {file_info, Size, Mode, Links, Inode, Uid, Gid, MajorDevice, Atime, Mtime, Ctime}};
            {error, Reason} when ?is_posix_error(Reason) ->
                Result
        end.