Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTDQDBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 23:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTDQDBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 23:01:04 -0400
Received: from ohsmtp03.ogw.rr.com ([65.24.7.38]:8162 "EHLO
	ohsmtp03.ogw.rr.com") by vger.kernel.org with ESMTP id S262543AbTDQDBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 23:01:03 -0400
Message-ID: <000501c3048d$a3e41700$0200a8c0@satellite>
From: "Dave Mehler" <dmehler26@woh.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: problems booting 2.5 kernel, rh9
Date: Wed, 16 Apr 2003 23:01:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    Compiled/installed a 2.5 kernel on my rh9 box, everything went alright.
When i try to boot it this is what i get, any ideas? I don't see an error,
very weird. I've installed the new modutils rpm and the procpsutils as well.
Thanks.
Dave.


Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.

    GRUB  version 0.93  (639K lower / 261040K upper memory)

 +-------------------------------------------------------------------------+
      Use the ^ and v keys to select which entry is highlighted.
      Press enter to boot the selected OS, 'e' to edit the
      commands before booting, 'a' to modify the kernel arguments
  Booting 'Red Hat Linux (2.5.67)'

root (hd0,0)
 Filesystem type is ext2fs, partition type 0x83
kernel /boot/vmlinuz-2.5.67 ro root=LABEL=/1 console=ttyS0
   [Linux-bzImage, setup=0x1400, size=0xe1aaf]
initrd /boot/initrd-2.5.67.img
   [Linux-initrd @ 0xffc7000, 0x14ffb bytes]


