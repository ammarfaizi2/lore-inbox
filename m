Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288657AbSANCOY>; Sun, 13 Jan 2002 21:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288660AbSANCOP>; Sun, 13 Jan 2002 21:14:15 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:14008 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288643AbSANCN6>; Sun, 13 Jan 2002 21:13:58 -0500
Date: Sun, 13 Jan 2002 19:14:58 -0700
Message-Id: <200201140214.g0E2Ewx12117@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.7 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.7 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.18-pre3. Highlights of this release:

- Unregister /dev/root symlink prior to creating second one (for
  initrd)

- Added support for multiple Compaq cpqarray controllers

- Fixed (rare, old) race in <devfs_lookup>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
