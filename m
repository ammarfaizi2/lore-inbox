Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270280AbRHMQmG>; Mon, 13 Aug 2001 12:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270299AbRHMQl5>; Mon, 13 Aug 2001 12:41:57 -0400
Received: from guestpc.physics.umanitoba.ca ([130.179.72.122]:8452 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270293AbRHMQln>; Mon, 13 Aug 2001 12:41:43 -0400
Date: Mon, 13 Aug 2001 11:41:27 -0500
Message-Id: <200108131641.f7DGfRX01182@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@mobilix.ras.ucalgary.ca
Subject: [PATCH] devfs v187 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 187 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.9-pre2. Highlights of this release:

- Fixed drivers/char/stallion.c for devfs

- Fixed drivers/char/rocket.c for devfs

- Fixed bug in <devfs_alloc_unique_number>: limited to 128 numbers

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
