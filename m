Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUBINMd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUBINMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:12:33 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:16648 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S265139AbUBINME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:12:04 -0500
Message-ID: <40279532.2000502@zvala.cz>
Date: Mon, 09 Feb 2004 14:12:02 +0000
From: Tomas Zvala <tomas@zvala.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.2-mm1 xfs OOPS (when mounting root fs)
Content-Type: multipart/mixed;
 boundary="------------050300040400010402050405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050300040400010402050405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
Well i hope i correctly identified lkml as the proper mailing list to 
report this.
I've got these oopses(oopses.txt attachment) when my XFS root filesystem 
gets mounted. Im also attaching my /proc/config.gz and xfs_info output.
If you need any more info let me know please.

Thank you,

Tomas Zvala



 

--------------050300040400010402050405
Content-Type: application/gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
--------------050300040400010402050405
Content-Type: text/plain;
 name="oopses.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oopses.txt"

XFS mounting filesystem hda2
i_size_write() called without i_sem
Call Trace:
 [<c01443d1>] i_size_write_check+0x5f/0x61
 [<c02c5969>] xfs_initialize_vnode+0xce/0x2e4
 [<c02c6ba8>] vfs_init_vnode+0x3c/0x40
 [<c02938b6>] xfs_iget_core+0x3c8/0x6ba
 [<c0293cff>] xfs_iget+0x157/0x189
 [<c02aa00b>] xfs_mountfs+0x7fe/0xfea
 [<c02c5d7a>] xfs_setsize_buftarg+0x40/0x7d
 [<c02a9547>] xfs_readsb+0x1c8/0x225
 [<c029a863>] xfs_ioinit+0x1e/0x34
 [<c02b1fae>] xfs_mount+0x337/0x5c9
 [<c02c6940>] vfs_mount+0x34/0x38
 [<c02c675f>] linvfs_fill_super+0xa1/0x21a
 [<c02d2662>] snprintf+0x27/0x2b
 [<c019ac5a>] disk_name+0x62/0xab
 [<c0166f8e>] sb_set_blocksize+0x25/0x53
 [<c01669d4>] get_sb_bdev+0x125/0x158
 [<c02c6907>] linvfs_get_sb+0x2f/0x34
 [<c02c66be>] linvfs_fill_super+0x0/0x21a
 [<c0166c09>] do_kern_mount+0x5f/0xd5
 [<c017e019>] do_add_mount+0x78/0x14e
 [<c017e312>] do_mount+0x139/0x17f
 [<c017e16f>] copy_mount_options+0x80/0xea
 [<c017e792>] sys_mount+0xd4/0x158
 [<c0536f9e>] do_mount_root+0x2f/0x9c
 [<c053705f>] mount_block_root+0x54/0x11d
 [<c05372a6>] mount_root+0x41/0x62
 [<c05372f2>] prepare_namespace+0x2b/0xd8
 [<c010723c>] init+0x1a4/0x1bc
 [<c0107098>] init+0x0/0x1bc
 [<c0109269>] kernel_thread_helper+0x5/0xb

i_size_write() called without i_sem
Call Trace:
 [<c01443d1>] i_size_write_check+0x5f/0x61
 [<c02c5969>] xfs_initialize_vnode+0xce/0x2e4
 [<c02c6ba8>] vfs_init_vnode+0x3c/0x40
 [<c02938b6>] xfs_iget_core+0x3c8/0x6ba
 [<c0293cff>] xfs_iget+0x157/0x189
 [<c0253ddf>] xfs_rtmount_inodes+0x7b/0x11c
 [<c02943d3>] xfs_iunlock+0x37/0x71
 [<c02aa092>] xfs_mountfs+0x885/0xfea
 [<c02c5d7a>] xfs_setsize_buftarg+0x40/0x7d
 [<c029a863>] xfs_ioinit+0x1e/0x34
 [<c02b1fae>] xfs_mount+0x337/0x5c9
 [<c02c6940>] vfs_mount+0x34/0x38
 [<c02c675f>] linvfs_fill_super+0xa1/0x21a
 [<c02d2662>] snprintf+0x27/0x2b
 [<c019ac5a>] disk_name+0x62/0xab
 [<c0166f8e>] sb_set_blocksize+0x25/0x53
 [<c01669d4>] get_sb_bdev+0x125/0x158
 [<c02c6907>] linvfs_get_sb+0x2f/0x34
 [<c02c66be>] linvfs_fill_super+0x0/0x21a
 [<c0166c09>] do_kern_mount+0x5f/0xd5
 [<c017e019>] do_add_mount+0x78/0x14e
 [<c017e312>] do_mount+0x139/0x17f
 [<c017e16f>] copy_mount_options+0x80/0xea
 [<c017e792>] sys_mount+0xd4/0x158
 [<c0536f9e>] do_mount_root+0x2f/0x9c
 [<c053705f>] mount_block_root+0x54/0x11d
 [<c05372a6>] mount_root+0x41/0x62
 [<c05372f2>] prepare_namespace+0x2b/0xd8
 [<c010723c>] init+0x1a4/0x1bc
 [<c0107098>] init+0x0/0x1bc
 [<c0109269>] kernel_thread_helper+0x5/0xb

i_size_write() called without i_sem
Call Trace:
 [<c01443d1>] i_size_write_check+0x5f/0x61
 [<c02c5969>] xfs_initialize_vnode+0xce/0x2e4
 [<c02c6ba8>] vfs_init_vnode+0x3c/0x40
 [<c02938b6>] xfs_iget_core+0x3c8/0x6ba
 [<c0293cff>] xfs_iget+0x157/0x189
 [<c0253e27>] xfs_rtmount_inodes+0xc3/0x11c
 [<c02943d3>] xfs_iunlock+0x37/0x71
 [<c02aa092>] xfs_mountfs+0x885/0xfea
 [<c02c5d7a>] xfs_setsize_buftarg+0x40/0x7d
 [<c029a863>] xfs_ioinit+0x1e/0x34
 [<c02b1fae>] xfs_mount+0x337/0x5c9
 [<c02c6940>] vfs_mount+0x34/0x38
 [<c02c675f>] linvfs_fill_super+0xa1/0x21a
 [<c02d2662>] snprintf+0x27/0x2b
 [<c019ac5a>] disk_name+0x62/0xab
 [<c0166f8e>] sb_set_blocksize+0x25/0x53
 [<c01669d4>] get_sb_bdev+0x125/0x158
 [<c02c6907>] linvfs_get_sb+0x2f/0x34
 [<c02c66be>] linvfs_fill_super+0x0/0x21a
 [<c0166c09>] do_kern_mount+0x5f/0xd5
 [<c017e019>] do_add_mount+0x78/0x14e
 [<c017e312>] do_mount+0x139/0x17f
 [<c017e16f>] copy_mount_options+0x80/0xea
 [<c017e792>] sys_mount+0xd4/0x158
 [<c0536f9e>] do_mount_root+0x2f/0x9c
 [<c053705f>] mount_block_root+0x54/0x11d
 [<c05372a6>] mount_root+0x41/0x62
 [<c05372f2>] prepare_namespace+0x2b/0xd8
 [<c010723c>] init+0x1a4/0x1bc
 [<c0107098>] init+0x0/0x1bc
 [<c0109269>] kernel_thread_helper+0x5/0xb

Ending clean XFS mount for filesystem: hda2
VFS: Mounted root (xfs filesystem) readonly.
i_size_write() called without i_sem
Call Trace:
 [<c01443d1>] i_size_write_check+0x5f/0x61
 [<c02c5969>] xfs_initialize_vnode+0xce/0x2e4
 [<c02c6ba8>] vfs_init_vnode+0x3c/0x40
 [<c02938b6>] xfs_iget_core+0x3c8/0x6ba
 [<c0293cff>] xfs_iget+0x157/0x189
 [<c02b0e1e>] xfs_dir_lookup_int+0xb4/0x12b
 [<c02b68e6>] xfs_lookup+0x50/0x88
 [<c02c382f>] linvfs_lookup+0x67/0x9f
 [<c016d804>] real_lookup+0xcd/0xf0
 [<c016daac>] do_lookup+0x96/0xa1
 [<c016e027>] link_path_walk+0x570/0xa84
 [<c01772ad>] dput+0x22/0x2b1
 [<c017e2af>] do_mount+0xd6/0x17f
 [<c015dee2>] sys_chroot+0x65/0xa3
 [<c0548e9e>] mount_devfs_fs+0x3c/0x68
 [<c010723c>] init+0x1a4/0x1bc
 [<c0107098>] init+0x0/0x1bc
 [<c0109269>] kernel_thread_helper+0x5/0xb

Mounted devfs on /dev
Freeing unused kernel memory: 384k freed
i_size_write() called without i_sem
Call Trace:
 [<c01443d1>] i_size_write_check+0x5f/0x61
 [<c02c5969>] xfs_initialize_vnode+0xce/0x2e4
 [<c02c6ba8>] vfs_init_vnode+0x3c/0x40
 [<c02938b6>] xfs_iget_core+0x3c8/0x6ba
 [<c0293cff>] xfs_iget+0x157/0x189
 [<c02b0e1e>] xfs_dir_lookup_int+0xb4/0x12b
 [<c02b68e6>] xfs_lookup+0x50/0x88
 [<c02c382f>] linvfs_lookup+0x67/0x9f
 [<c016d804>] real_lookup+0xcd/0xf0
 [<c016daac>] do_lookup+0x96/0xa1
 [<c016dbd9>] link_path_walk+0x122/0xa84
 [<c0145b7c>] buffered_rmqueue+0xef/0x1af
 [<c016a696>] open_exec+0x2f/0xed
 [<c016b98e>] do_execve+0x20/0x241
 [<c01fde38>] devfs_mk_dev+0xd6/0x116
 [<c0145fca>] get_zeroed_page+0x25/0x65
 [<c0300e35>] n_tty_open+0x7e/0x9e
 [<c02fbf93>] init_dev+0x58/0x557
 [<c01fdf0b>] devfs_mk_cdev+0x36/0x5d
 [<c03060cd>] vcs_make_devfs+0x60/0x68
 [<c030d68a>] con_open+0xa4/0xa6
 [<c030d5e6>] con_open+0x0/0xa6
 [<c02fd023>] tty_open+0x24c/0x384
 [<c0168c76>] chrdev_open+0x123/0x291
 [<c015e480>] dentry_open+0x152/0x222
 [<c015e32c>] filp_open+0x62/0x64
 [<c016d3cf>] getname+0x97/0xc3
 [<c0109c0b>] sys_execve+0x42/0x7a
 [<c044408b>] syscall_call+0x7/0xb
 [<c010708a>] run_init_process+0x1c/0x2a
 [<c01071b3>] init+0x11b/0x1bc
 [<c0107098>] init+0x0/0x1bc
 [<c0109269>] kernel_thread_helper+0x5/0xb

i_size_write() called without i_sem
Call Trace:
 [<c01443d1>] i_size_write_check+0x5f/0x61
 [<c02c5969>] xfs_initialize_vnode+0xce/0x2e4
 [<c02c6ba8>] vfs_init_vnode+0x3c/0x40
 [<c02938b6>] xfs_iget_core+0x3c8/0x6ba
 [<c0293cff>] xfs_iget+0x157/0x189
 [<c02b0e1e>] xfs_dir_lookup_int+0xb4/0x12b
 [<c02b68e6>] xfs_lookup+0x50/0x88
 [<c02c382f>] linvfs_lookup+0x67/0x9f
 [<c016d804>] real_lookup+0xcd/0xf0
 [<c016daac>] do_lookup+0x96/0xa1
 [<c016e027>] link_path_walk+0x570/0xa84
 [<c016a696>] open_exec+0x2f/0xed
 [<c016b98e>] do_execve+0x20/0x241
 [<c01fde38>] devfs_mk_dev+0xd6/0x116
 [<c0145fca>] get_zeroed_page+0x25/0x65
 [<c0300e35>] n_tty_open+0x7e/0x9e
 [<c02fbf93>] init_dev+0x58/0x557
 [<c01fdf0b>] devfs_mk_cdev+0x36/0x5d
 [<c03060cd>] vcs_make_devfs+0x60/0x68
 [<c030d68a>] con_open+0xa4/0xa6
 [<c030d5e6>] con_open+0x0/0xa6
 [<c02fd023>] tty_open+0x24c/0x384
 [<c0168c76>] chrdev_open+0x123/0x291
 [<c015e480>] dentry_open+0x152/0x222
 [<c015e32c>] filp_open+0x62/0x64
 [<c016d3cf>] getname+0x97/0xc3
 [<c0109c0b>] sys_execve+0x42/0x7a
 [<c044408b>] syscall_call+0x7/0xb
 [<c010708a>] run_init_process+0x1c/0x2a
 [<c01071b3>] init+0x11b/0x1bc
 [<c0107098>] init+0x0/0x1bc
 [<c0109269>] kernel_thread_helper+0x5/0xb

i_size_write() called without i_sem
Call Trace:
 [<c01443d1>] i_size_write_check+0x5f/0x61
 [<c02c5969>] xfs_initialize_vnode+0xce/0x2e4
 [<c02c6ba8>] vfs_init_vnode+0x3c/0x40
 [<c02938b6>] xfs_iget_core+0x3c8/0x6ba
 [<c0293cff>] xfs_iget+0x157/0x189
 [<c02b0e1e>] xfs_dir_lookup_int+0xb4/0x12b
 [<c02b68e6>] xfs_lookup+0x50/0x88
 [<c02c382f>] linvfs_lookup+0x67/0x9f
 [<c016d804>] real_lookup+0xcd/0xf0
 [<c016daac>] do_lookup+0x96/0xa1
 [<c016dbd9>] link_path_walk+0x122/0xa84
 [<c01423da>] file_read_actor+0x0/0xea
 [<c029440b>] xfs_iunlock+0x6f/0x71
 [<c016a696>] open_exec+0x2f/0xed
 [<c018c152>] load_elf_binary+0xb29/0xc3d
 [<c011dfa0>] pgd_alloc+0x18/0x1c
 [<c0145b7c>] buffered_rmqueue+0xef/0x1af
 [<c0145cd9>] __alloc_pages+0x9d/0x328
 [<c016a26e>] copy_strings+0x1a1/0x233
 [<c018b629>] load_elf_binary+0x0/0xc3d
 [<c016b817>] search_binary_handler+0x19f/0x2f6
 [<c016bb3b>] do_execve+0x1cd/0x241
 [<c0109c0b>] sys_execve+0x42/0x7a
 [<c044408b>] syscall_call+0x7/0xb
 [<c010708a>] run_init_process+0x1c/0x2a
 [<c01071b3>] init+0x11b/0x1bc
 [<c0107098>] init+0x0/0x1bc
 [<c0109269>] kernel_thread_helper+0x5/0xb

i_size_write() called without i_sem
Call Trace:
 [<c01443d1>] i_size_write_check+0x5f/0x61
 [<c02c5969>] xfs_initialize_vnode+0xce/0x2e4
 [<c02c6ba8>] vfs_init_vnode+0x3c/0x40
 [<c02938b6>] xfs_iget_core+0x3c8/0x6ba
 [<c0293cff>] xfs_iget+0x157/0x189
 [<c02b0e1e>] xfs_dir_lookup_int+0xb4/0x12b
 [<c02b68e6>] xfs_lookup+0x50/0x88
 [<c02c382f>] linvfs_lookup+0x67/0x9f
 [<c016d804>] real_lookup+0xcd/0xf0
 [<c016daac>] do_lookup+0x96/0xa1
 [<c016e027>] link_path_walk+0x570/0xa84
 [<c01423da>] file_read_actor+0x0/0xea
 [<c029440b>] xfs_iunlock+0x6f/0x71
 [<c016a696>] open_exec+0x2f/0xed
 [<c018c152>] load_elf_binary+0xb29/0xc3d
 [<c011dfa0>] pgd_alloc+0x18/0x1c
 [<c0145b7c>] buffered_rmqueue+0xef/0x1af
 [<c0145cd9>] __alloc_pages+0x9d/0x328
 [<c016a26e>] copy_strings+0x1a1/0x233
 [<c018b629>] load_elf_binary+0x0/0xc3d
 [<c016b817>] search_binary_handler+0x19f/0x2f6
 [<c016bb3b>] do_execve+0x1cd/0x241
 [<c0109c0b>] sys_execve+0x42/0x7a
 [<c044408b>] syscall_call+0x7/0xb
 [<c010708a>] run_init_process+0x1c/0x2a
 [<c01071b3>] init+0x11b/0x1bc
 [<c0107098>] init+0x0/0x1bc
 [<c0109269>] kernel_thread_helper+0x5/0xb

i_size_write() called without i_sem
Call Trace:
 [<c01443d1>] i_size_write_check+0x5f/0x61
 [<c02c5969>] xfs_initialize_vnode+0xce/0x2e4
 [<c02c6ba8>] vfs_init_vnode+0x3c/0x40
 [<c02938b6>] xfs_iget_core+0x3c8/0x6ba
 [<c0293cff>] xfs_iget+0x157/0x189
 [<c02b0e1e>] xfs_dir_lookup_int+0xb4/0x12b
 [<c02b68e6>] xfs_lookup+0x50/0x88
 [<c02c382f>] linvfs_lookup+0x67/0x9f
 [<c016d804>] real_lookup+0xcd/0xf0
 [<c016daac>] do_lookup+0x96/0xa1
 [<c016e027>] link_path_walk+0x570/0xa84
 [<c02c3848>] linvfs_lookup+0x80/0x9f
 [<c0170cac>] vfs_follow_link+0x37/0x1fa
 [<c02c3ccf>] linvfs_follow_link+0xf0/0x10d
 [<c016e0ed>] link_path_walk+0x636/0xa84
 [<c01423da>] file_read_actor+0x0/0xea
 [<c029440b>] xfs_iunlock+0x6f/0x71
 [<c016a696>] open_exec+0x2f/0xed
 [<c018c152>] load_elf_binary+0xb29/0xc3d
 [<c011dfa0>] pgd_alloc+0x18/0x1c
 [<c0145b7c>] buffered_rmqueue+0xef/0x1af
 [<c0145cd9>] __alloc_pages+0x9d/0x328
 [<c016a26e>] copy_strings+0x1a1/0x233
 [<c018b629>] load_elf_binary+0x0/0xc3d
 [<c016b817>] search_binary_handler+0x19f/0x2f6
 [<c016bb3b>] do_execve+0x1cd/0x241
 [<c0109c0b>] sys_execve+0x42/0x7a
 [<c044408b>] syscall_call+0x7/0xb
 [<c010708a>] run_init_process+0x1c/0x2a
 [<c01071b3>] init+0x11b/0x1bc
 [<c0107098>] init+0x0/0x1bc
 [<c0109269>] kernel_thread_helper+0x5/0xb

i_size_write() called without i_sem
Call Trace:
 [<c01443d1>] i_size_write_check+0x5f/0x61
 [<c02c5969>] xfs_initialize_vnode+0xce/0x2e4
 [<c02c6ba8>] vfs_init_vnode+0x3c/0x40
 [<c02938b6>] xfs_iget_core+0x3c8/0x6ba
 [<c0293cff>] xfs_iget+0x157/0x189
 [<c02b0e1e>] xfs_dir_lookup_int+0xb4/0x12b
 [<c02b68e6>] xfs_lookup+0x50/0x88
 [<c02c382f>] linvfs_lookup+0x67/0x9f
 [<c016d804>] real_lookup+0xcd/0xf0
 [<c016daac>] do_lookup+0x96/0xa1
 [<c016dbd9>] link_path_walk+0x122/0xa84
 [<c016ef8d>] open_namei+0x83/0x405
 [<c015e308>] filp_open+0x3e/0x64
 [<c015e874>] sys_open+0x5b/0x8b
 [<c044408b>] syscall_call+0x7/0xb

Adding 999896k swap on /dev/hda6.  Priority:-1 extents:1
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
XFS mounting filesystem hda5
Ending clean XFS mount for filesystem: hda5
XFS mounting filesystem hda7
Ending clean XFS mount for filesystem: hda7
XFS mounting filesystem hda8
Ending clean XFS mount for filesystem: hda8
XFS mounting filesystem hda9
Ending clean XFS mount for filesystem: hda9
XFS mounting filesystem hda10
Ending clean XFS mount for filesystem: hda10
XFS mounting filesystem hda11
Ending clean XFS mount for filesystem: hda11
XFS mounting filesystem hda12
Ending clean XFS mount for filesystem: hda12
XFS mounting filesystem hda13
Ending clean XFS mount for filesystem: hda13

--------------050300040400010402050405
Content-Type: text/plain;
 name="xfs_info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xfs_info.txt"

meta-data=/                      isize=256    agcount=8, agsize=31248 blks
         =                       sectsz=512  
data     =                       bsize=4096   blocks=249984, imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=0
naming   =version 2              bsize=4096  
log      =internal               bsize=4096   blocks=1200, version=2
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0

--------------050300040400010402050405--
