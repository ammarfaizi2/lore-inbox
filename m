Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289077AbSAUGgc>; Mon, 21 Jan 2002 01:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289080AbSAUGgW>; Mon, 21 Jan 2002 01:36:22 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:21641 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289077AbSAUGgH>; Mon, 21 Jan 2002 01:36:07 -0500
Date: Sun, 20 Jan 2002 23:35:45 -0700
Message-Id: <200201210635.g0L6ZjA22202@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.8 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.8 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.18-pre4. Highlights of this release:

- Fixed deadlock bug in <devfs_d_revalidate_wait>

- Tag VFS deletable in <devfs_mk_symlink> if handle ignored

- Updated README from master HTML file

- Fixed kdev_none macro in include/linux/kdev_t.h

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
