Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271657AbRH0GU0>; Mon, 27 Aug 2001 02:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271658AbRH0GUQ>; Mon, 27 Aug 2001 02:20:16 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:56235 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271657AbRH0GUJ>; Mon, 27 Aug 2001 02:20:09 -0400
Date: Mon, 27 Aug 2001 00:20:28 -0600
Message-Id: <200108270620.f7R6KST12679@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v191 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 191 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

REMINDER: this patch and earlier patches include support for >2000
SCSI discs.

This is against 2.4.9. Highlights of this release:

- Replaced global rwsem for symlink with per-link refcount

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
