Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280999AbRKCRrv>; Sat, 3 Nov 2001 12:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281000AbRKCRrc>; Sat, 3 Nov 2001 12:47:32 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:36792 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S280999AbRKCRrV>; Sat, 3 Nov 2001 12:47:21 -0500
Date: Sat, 3 Nov 2001 10:47:00 -0700
Message-Id: <200111031747.fA3Hl0u19223@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v196 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 196 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.14-pre7. Highlights of this release:

- Fixed race in <devfsd_ioctl> when setting event mask
  Thanks to Kari Hurtta <hurtta@leija.mh.fmi.fi>

- Avoid deadlock in <devfs_follow_link> by using temporary buffer

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
