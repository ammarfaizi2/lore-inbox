Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264324AbRFHUJA>; Fri, 8 Jun 2001 16:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264322AbRFHUIl>; Fri, 8 Jun 2001 16:08:41 -0400
Received: from rumor.cps.intel.com ([192.102.198.242]:56035 "EHLO
	rumor.cps.intel.com") by vger.kernel.org with ESMTP
	id <S264321AbRFHUId>; Fri, 8 Jun 2001 16:08:33 -0400
Message-ID: <9319DDF797C4D211AC4700A0C96B7C9404AC200D@orsmsx42.jf.intel.com>
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: mkinitrd errors...
Date: Fri, 8 Jun 2001 13:08:22 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have a need to have some drivers pre-loaded before the scsi adapter driver
is loaded.

I followed the usage and i got some errors which iam attaching below in this
mail.

If someone can give me a way to get this to work that would be awesome!!!

please reply back to me..

1. Is the size of the ramdisk limited? if so to what, and how can we
increase the size of the ramdisk created?

tar: ./lib/82808XA.o: Wrote only 3584 of 10240 bytes
tar: Skipping to next header
tar: ./lib/sd_mod.o: Wrote only 0 of 10240 bytes
tar: Skipping to next header
tar: ./bin/nash: Wrote only 0 of 10240 bytes
tar: Skipping to next header
tar: ./sbin/: Cannot mkdir: No space left on device
tar: ./sbin/bin: Cannot open: No such file or directory
tar: ./sbin/modprobe: Cannot create symlink to `/bin/nash': No such file or
dire
ctory
tar: ./etc/: Cannot mkdir: No space left on device
tar: ./dev/: Cannot mkdir: No space left on device
tar: ./dev/console: Cannot mknod: No such file or directory
tar: ./dev/null: Cannot mknod: No such file or directory
tar: ./dev/ram: Cannot mknod: No such file or directory
tar: ./dev/systty: Cannot mknod: No such file or directory
tar: ./dev/tty1: Cannot mknod: No such file or directory
tar: ./dev/tty2: Cannot mknod: No such file or directory
tar: ./dev/tty3: Cannot mknod: No such file or directory
tar: ./dev/tty4: Cannot mknod: No such file or directory
tar: ./loopfs/: Cannot mkdir: No space left on device
tar: ./linuxrc: Wrote only 0 of 10240 bytes
tar: Error exit delayed from previous errors


