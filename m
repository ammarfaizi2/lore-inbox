Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271365AbRHTQVY>; Mon, 20 Aug 2001 12:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271361AbRHTQVN>; Mon, 20 Aug 2001 12:21:13 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:29085 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271352AbRHTQVH>; Mon, 20 Aug 2001 12:21:07 -0400
Date: Mon, 20 Aug 2001 10:20:52 -0600
Message-Id: <200108201620.f7KGKqw01274@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v188 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 188 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.9. Highlights of this release:

- Updated major masks in fs/devfs/util.c up to Linus' "no new majors"
  proclamation. Block: were 126 now 122 free, char: were 26 now 19 free

- Updated README from master HTML file

- Removed remnant of multi-mount support in <devfs_mknod>

- Removed unused DEVFS_FL_SHOW_UNREG flag

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
