Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSHUETW>; Wed, 21 Aug 2002 00:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSHUETW>; Wed, 21 Aug 2002 00:19:22 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:12193 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317833AbSHUETV>; Wed, 21 Aug 2002 00:19:21 -0400
Date: Tue, 20 Aug 2002 22:23:16 -0600
Message-Id: <200208210423.g7L4NGM21965@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v217 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 217 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.31. Highlights of this release:

- Exported <devfs_find_and_unregister> and <devfs_only> to modules

- Updated README from master HTML file

- Fixed module unload race in <devfs_open>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
