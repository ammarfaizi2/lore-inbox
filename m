Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269818AbRHDHPP>; Sat, 4 Aug 2001 03:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269822AbRHDHPF>; Sat, 4 Aug 2001 03:15:05 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:21376 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269818AbRHDHO5>; Sat, 4 Aug 2001 03:14:57 -0400
Date: Sat, 4 Aug 2001 01:14:48 -0600
Message-Id: <200108040714.f747Emh02927@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v184 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 184 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.7. Highlights of this release:

- Support large numbers of SCSI discs (~2144)

- Documentation typo fix for fs/devfs/util.c

- Fixed drivers/char/stallion.c for devfs

- Added DEVFSD_NOTIFY_DELETE event

- Updated README from master HTML file

- Removed #include <asm/segment.h> from fs/devfs/base.c

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
