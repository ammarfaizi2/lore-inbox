Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSKGSuY>; Thu, 7 Nov 2002 13:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSKGSuX>; Thu, 7 Nov 2002 13:50:23 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:51091 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261472AbSKGSuV> convert rfc822-to-8bit; Thu, 7 Nov 2002 13:50:21 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
Subject: [ANNOUNCE] WOLK v3.7.1 UPDATE // [PATCH]
Date: Thu, 7 Nov 2002 19:57:14 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211071957.14365.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

just an update for 3.7 FINAL to fix some major build problems.


Changelog from v3.7 -> v3.7.1
-----------------------------
o   add:        autoregulating timeslice duration (from -ck13)
o   add:        IDE-SCSI (start DMA at the right time)
o   add:        csum and csum_copy routines with boot-time selection
o   add:        LVM updates from 2.4.19 and 2.4.20-pre11
o   add:        USB: KB Gear JamStudio tablet support 
o   add:        2.4 VM suckiness fixes
+   add:        More Framebuffer Boot Logos
+   fixed:      kernel/timer.c: parse error before `}'
+   fixed:      fs/ext3/resize.c: undefined reference to `get_empty_inode'
+   fixed:      internal.h:48: redefinition of `PDE'
+   fixed:      include/linux/seq_file.h: void *private
o   fixed:      net/ipsec/alg/* wrong symlinks
o   fixed:      unresolved symbol: tcp_v4_lookup_listener
o   fixed:      Crypto Hardware Accelerator Support conflicts with CryptoAPI
o   fixed:      Win4Lin: missing kernel/sched.c additions
o   fixed:      "If I run mldonkey, WOLK oops() and sometimes panic()"
o   fixed:      Win4Lin: should now work with Preempt
o   update:     Win4Lin: latest MKI-Adapter patch
                 Supporting Win4Lin v3.0.6 and v4.0.x
o   update:     CPU Frequency Scaling v2.4.19-10
o   update:     Device-Mapper v1.03-ioctl (2002-08-14)
o   update:     Oracle Cluster File System (OCFS) latest snapshots
o   change:     Moved CryptoAPI to Security Options menu
o   change:     ALSA and kernel sound core are selectable at the same time
+   change:     Moved AFS to Network Filesystems



Release Info:
-------------
Date   : November, 7th, 2002
Time   : 8:00 pm CET
URL    : http://sf.net/projects/wolk


md5sums:
--------
2e8b0824a4e211a53ad998e3aad97637 *linux-2.4.18-wolk3.7-to-3.7.1.patch.bz2
5b3afd4c71e796a5e81c9f7547674d88 *linux-2.4.18-wolk3.7-to-3.7.1.patch.gz


Have fun!

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


