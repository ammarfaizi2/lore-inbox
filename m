Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289092AbSAUGhm>; Mon, 21 Jan 2002 01:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289080AbSAUGhX>; Mon, 21 Jan 2002 01:37:23 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:23177 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289081AbSAUGhS>; Mon, 21 Jan 2002 01:37:18 -0500
Date: Sun, 20 Jan 2002 23:37:12 -0700
Message-Id: <200201210637.g0L6bCH22270@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v207 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 207 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.3-pre2. Highlights of this release:

- Fixed deadlock bug in <devfs_d_revalidate_wait>

- Tag VFS deletable in <devfs_mk_symlink> if handle ignored

- Updated README from master HTML file

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
