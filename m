Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTB0WY5>; Thu, 27 Feb 2003 17:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTB0WXt>; Thu, 27 Feb 2003 17:23:49 -0500
Received: from hera.cwi.nl ([192.16.191.8]:54204 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267274AbTB0WXi>;
	Thu, 27 Feb 2003 17:23:38 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 27 Feb 2003 23:33:56 +0100 (MET)
Message-Id: <UTC200302272233.h1RMXu324918.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [OT] man-pages 1.56 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just released man-pages 1.56 with
===
    The man pages

        fgetxattr.2 flistxattr.2 fremovexattr.2 fsetxattr.2
        getxattr.2 get_thread_area.2 io_cancel.2 io_destroy.2
        io_getevents.2 io_setup.2 io_submit.2 lgetxattr.2 listxattr.2
        llistxattr.2 lookup_dcookie.2 lremovexattr.2 lsetxattr.2
        posix_fadvise.2 readahead.2 removexattr.2 setxattr.2
	set_thread_area.2

        ftw.3 openpty.3

    are new or have been updated.
===

In short: lots of new syscall pages.

Now that the call for syscall docs was so successful, let me
ask something else. We have console_ioctl.4 and tty_ioctl.4
but lots of other *_ioctl.4 things are wanted.
Contributions are welcome.

Andries - aeb@cwi.nl
