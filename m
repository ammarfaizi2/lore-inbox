Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284346AbRLCIvo>; Mon, 3 Dec 2001 03:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284422AbRLCIuO>; Mon, 3 Dec 2001 03:50:14 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:51647 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284822AbRLCGhr>; Mon, 3 Dec 2001 01:37:47 -0500
Date: Sun, 2 Dec 2001 23:36:16 -0700
Message-Id: <200112030636.fB36aGA18070@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.1 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.1 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.17-pre2. Highlights of this release:

- Fixed bug in <devfsd_read>: was dereferencing freed pointer

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
