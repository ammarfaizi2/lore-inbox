Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283770AbRLOVhw>; Sat, 15 Dec 2001 16:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283924AbRLOVhm>; Sat, 15 Dec 2001 16:37:42 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:6056 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283770AbRLOVh2>; Sat, 15 Dec 2001 16:37:28 -0500
Date: Sat, 15 Dec 2001 14:37:36 -0700
Message-Id: <200112152137.fBFLbaU17467@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.4 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.4 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.17-rc1. Highlights of this release:

- Removed long obsolete rc.devfs

- Return old entry in <devfs_mk_dir> for 2.4.x kernels

- Updated README from master HTML file

- Increment refcount on module in <check_disc_changed>

- Created <devfs_get_handle> and exported <devfs_put>

- Increment refcount on module in <devfs_get_ops>

- Created <devfs_put_ops> and used where needed to fix races

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
