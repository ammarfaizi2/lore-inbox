Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284347AbRLCIve>; Mon, 3 Dec 2001 03:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284475AbRLCIug>; Mon, 3 Dec 2001 03:50:36 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:58303 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284825AbRLCGt7>; Mon, 3 Dec 2001 01:49:59 -0500
Date: Sun, 2 Dec 2001 23:49:46 -0700
Message-Id: <200112030649.fB36nkd18320@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v201 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 201 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

This is against 2.5.1-pre5. Highlights of this release:

- Fixed bug in <devfsd_read>: was dereferencing freed pointer

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
