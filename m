Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbRFBDqc>; Fri, 1 Jun 2001 23:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbRFBDqX>; Fri, 1 Jun 2001 23:46:23 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:39689 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261238AbRFBDqD>; Fri, 1 Jun 2001 23:46:03 -0400
Subject: Announce: Win2K LDM Docs (Logical Disk Manager)
From: Richard Russon <kernel@flatcap.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <991453346.13012.3.camel@home.flatcap.org>
Mime-Version: 1.0
X-Mailer: Evolution/0.10 (Preview Release)
Date: 02 Jun 2001 04:46:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm pleased to announce the first version of the LDM Documentation.

Windows 2000 introduced a new partitioning scheme and with it, the
Logical Disk Manager.  Like Linux's Logical Volume Manager is allows
changes to partitioning, and volumes, to be made without rebooting.
To create Mirrored, Spanned, Striped or RAID disks under Win2K, you
must use their "Dynamic Disks".

Unfortunately Linux cannot read these Dynamic Disks.  Yet.

The documentation, although only a first draft, contains enough
information to locate and piece together the disks, partitions and
volumes used by Win2K.  The docs show the on-disk structures that
make up the 1MB database at the end of the physical disk.

The docs are available online at:

  http://linux-ntfs.sourceforge.net/ldm

and to download at:

  http://sourceforge.net/project/showfiles.php?group_id=13956

Also, I've written a test program to dump the LDM information stored
on a dynamic disk.  It's available at:

  http://linux-ntfs.sourceforge.net/ldm/ldm.c

If you have any questions, comments or additions, please email me.

Thanks,
  FlatCap (Richard Russon)
  ntfs@flatcap.org


