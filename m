Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281547AbRLDSqL>; Tue, 4 Dec 2001 13:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282910AbRLDSpB>; Tue, 4 Dec 2001 13:45:01 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:40643 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283232AbRLDSnZ>; Tue, 4 Dec 2001 13:43:25 -0500
Date: Tue, 4 Dec 2001 11:43:08 -0700
Message-Id: <200112041843.fB4Ih8l09767@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.3 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.3 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.17-pre2. Highlights of this release:

- Use SLAB_ATOMIC in <devfsd_notify_de> from <devfs_d_delete>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
