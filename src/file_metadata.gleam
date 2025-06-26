import gleam/int
import gleam/io

pub fn main() -> Nil {
  let x = read_file_info("gleam.toml")

  io.println(case x {
    Ok(fileinfo) ->
      "Gleam toml size is: " <> int.to_string(fileinfo.size) <> " Bytes!"
    _ -> "Nah dog"
  })

  io.println("Hello from file_metadata!")
}

@external(erlang, "gleam_erlang_file_ffi", "file_info")
fn read_file_info(filepath: String) -> Result(FileInfo, FileError)

pub type FileError {
  /// Permission denied.
  Eacces
  /// Resource temporarily unavailable.
  Eagain
  /// Bad file number
  Ebadf
  /// Bad message.
  Ebadmsg
  /// File busy.
  Ebusy
  /// Resource deadlock avoided.
  Edeadlk
  /// On most architectures, same as `Edeadlk`. On some architectures, it
  /// means "File locking deadlock error."
  Edeadlock
  /// Disk quota exceeded.
  Edquot
  /// File already exists.
  Eexist
  /// Bad address in system call argument.
  Efault
  /// File too large.
  Efbig
  /// Inappropriate file type or format. Usually caused by trying to set the
  /// "sticky bit" on a regular file (not a directory).
  Eftype
  /// Interrupted system call.
  Eintr
  /// Invalid argument.
  Einval
  /// I/O error.
  Eio
  /// Illegal operation on a directory.
  Eisdir
  /// Too many levels of symbolic links.
  Eloop
  /// Too many open files.
  Emfile
  /// Too many links.
  Emlink
  /// Multihop attempted.
  Emultihop
  /// Filename too long
  Enametoolong
  /// File table overflow
  Enfile
  /// No buffer space available.
  Enobufs
  /// No such device.
  Enodev
  /// No locks available.
  Enolck
  /// Link has been severed.
  Enolink
  /// No such file or directory.
  Enoent
  /// Not enough memory.
  Enomem
  /// No space left on device.
  Enospc
  /// No STREAM resources.
  Enosr
  /// Not a STREAM.
  Enostr
  /// Function not implemented.
  Enosys
  /// Block device required.
  Enotblk
  /// Not a directory.
  Enotdir
  /// Operation not supported.
  Enotsup
  /// No such device or address.
  Enxio
  /// Operation not supported on socket.
  Eopnotsupp
  /// Value too large to be stored in data type.
  Eoverflow
  /// Not owner.
  Eperm
  /// Broken pipe.
  Epipe
  /// Result too large.
  Erange
  /// Read-only file system.
  Erofs
  /// Invalid seek.
  Espipe
  /// No such process.
  Esrch
  /// Stale remote file handle.
  Estale
  /// Text file busy.
  Etxtbsy
  /// Cross-domain link.
  Exdev
  /// File was requested to be read as UTF-8, but is not UTF-8 encoded.
  NotUtf8
  /// Any error not accounted for by this type
  Unknown(inner: String)
}

pub type FileInfo {
  FileInfo(
    /// File size in bytes.
    size: Int,
    /// File mode that indicates the file type and its permissions.
    /// For example, in Unix and Linux, a mode value of 33188 indicates
    /// a regular file and the permissions associated with it
    /// (read and write for the owner, and read-only for others, in
    /// this case).
    mode: Int,
    /// Number of hard links that exist for the file.
    nlinks: Int,
    /// Inode number, which is a unique identifier for the file in the filesystem.
    inode: Int,
    /// User ID of the file's owner.
    user_id: Int,
    /// Group ID of the file's group.
    group_id: Int,
    /// Device ID of the file's major device.
    /// TODO: We can actually get a major device and minor device from both
    /// node and erlang. The `fs.stat` in node returns a `dev` and `rdev`,
    /// so we can use some bitwise operations to get the minor out of `rdev`.
    /// Someone who's not me should totally make a PR for that.
    dev: Int,
    /// The last access time in seconds since the UNIX epoch (00:00:00 UTC on 1 January 1970).
    atime_seconds: Int,
    /// The last modification time in seconds since the UNIX epoch (00:00:00 UTC on 1 January 1970).
    mtime_seconds: Int,
    /// The last change time in seconds since the UNIX epoch (00:00:00 UTC on 1 January 1970).
    ctime_seconds: Int,
  )
}
