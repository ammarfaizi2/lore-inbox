Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbULEO2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbULEO2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 09:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbULEO2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 09:28:44 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:4799 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261306AbULEO2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 09:28:42 -0500
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.5  (F2.73; T1.001; A1.64; B3.05; Q3.03)
Cc: kernelnewbies@nl.linux.org, anandrajm@fastmail.fm
Subject: Booting 2.6.10-rc3
To: linux-kernel@vger.kernel.org
Date: Sun, 05 Dec 2004 06:28:36 -0800
From: "Anandraj" <anandrajm@fastmail.fm>
X-Sasl-Enc: BPiT3v1E8beZagV7FToUhA 1102256916
Message-Id: <1102256916.29858.210104494@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
My linux box with 2.6.9 kernel patched with 2.6.10-rc3 patch doesnot
come up.
It shows the following while booting-

root(hd0,4)
Filesystem type is ext2fs , partition type 0x83
kernel /vmlinuz-2.6.10-rc3 ro root=LABLE=/ rhgb quiet
    [Linux-bzImage, setup=0x1400,size=0x187b53]
initrd /initrd-2.6.10-rc3.img
    [Linux-initrd @ 0x1fcb1000,0x2eb22 bytes]

Uncompressing Linux... Ok, booting kernel
audit(1102189352.204:0):initialized
Red Hat nash version 3.5.22 starting 
mount: error 6 mounting ext3
pivotroot: pivo_root(/sysroot,/sysroot/initrd) failed : 2
umount /initrd/proc failed: 2
Kenel panic - not syncing: No init found. Try Passing init=option to
kernel.


I am using Fedora 2 distro!
The default kernel 2.6.5-1.358 that comes along with the distro works !

I had looked into various forums for "mount: error 6 mounting ext3",
none of the aswers given by them worked,
the answers like , making your ext3 module inbuilt ,also does not work !

Mine is a simple desktop PC with Pentium 4 512MB RAM, it does not deal
with any SCSI stuff!
Can somebody help me on this !! ??

TIA,
Anand

