Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S316820AbSEVBRn>; Tue, 21 May 2002 21:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S316822AbSEVBRm>; Tue, 21 May 2002 21:17:42 -0400
Received: from fwout.nihs.go.jp ([202.241.36.162]:48193 "EHLO smtp") by vger.kernel.org with ESMTP id <S316820AbSEVBRl>; Tue, 21 May 2002 21:17:41 -0400
Message-ID: <001301c2012e$678be520$f3c4b5cb@k768>
From: "Takuya Satoh" <taka0038@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Cc: <joerg@infolinux.de>
Subject: RE: [PATCHSET] 2.4.19-pre8-jp13
Date: Wed, 22 May 2002 10:17:11 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Errors again:

init/do_mounts.c:26: conflicting types for `sys_chdir'
/usr/src/linux-2.4.19-pre8-jp13/include/linux/fs.h:677: previous declaration
of `sys_chdir'
init/do_mounts.c:27: conflicting types for `sys_chroot'
/usr/src/linux-2.4.19-pre8-jp13/include/linux/fs.h:676: previous declaration
of `sys_chroot'
init/do_mounts.c:369: warning: `mount_nfs_root' defined but not used
init/do_mounts.c:400: warning: `change_floppy' defined but not used
init/do_mounts.c:989: warning: `crd_load' defined but not used
make: *** [init/do_mounts.o] Error 1
errors during make bzImage, exiting


