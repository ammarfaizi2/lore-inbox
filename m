Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSG1R7R>; Sun, 28 Jul 2002 13:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316994AbSG1R7R>; Sun, 28 Jul 2002 13:59:17 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:24194 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S316971AbSG1R7R>; Sun, 28 Jul 2002 13:59:17 -0400
Date: Sun, 28 Jul 2002 12:01:59 -0600
Message-Id: <200207281801.g6SI1xr28889@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v215 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 215 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.28. Highlights of this release:

- Created <devfs_find_and_unregister>

- Switched many functions from <devfs_find_handle> to
  <devfs_find_and_unregister>

- Switched many functions from <devfs_find_handle> to <devfs_get_handle>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
