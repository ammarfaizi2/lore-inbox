Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283321AbRLDTOC>; Tue, 4 Dec 2001 14:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283244AbRLDSqO>; Tue, 4 Dec 2001 13:46:14 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43203 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283230AbRLDSp1>; Tue, 4 Dec 2001 13:45:27 -0500
Date: Tue, 4 Dec 2001 11:45:15 -0700
Message-Id: <200112041845.fB4IjFl09926@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v203 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 203 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.1-pre5. Highlights of this release:

- Use SLAB_ATOMIC in <devfsd_notify_de> from <devfs_d_delete>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
