Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288690AbSANCmP>; Sun, 13 Jan 2002 21:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288686AbSANCmG>; Sun, 13 Jan 2002 21:42:06 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:23224 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288691AbSANClx>; Sun, 13 Jan 2002 21:41:53 -0500
Date: Sun, 13 Jan 2002 19:42:52 -0700
Message-Id: <200201140242.g0E2gqJ12776@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v206 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 206 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.2-pre11. Highlights of this release:

- Added support for multiple Compaq cpqarray controllers

- Fixed (rare, old) race in <devfs_lookup>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
