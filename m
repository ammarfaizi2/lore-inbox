Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311264AbSDNUe3>; Sun, 14 Apr 2002 16:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312453AbSDNUe2>; Sun, 14 Apr 2002 16:34:28 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:17805 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S311264AbSDNUe2>; Sun, 14 Apr 2002 16:34:28 -0400
Date: Sun, 14 Apr 2002 14:33:34 -0600
Message-Id: <200204142033.g3EKXYG19293@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v210 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 210 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.8. Highlights of this release:

- Updated fs/devfs/util.c to fix shift warning on 64 bit machines
  Thanks to Anton Blanchard <anton@samba.org>

- Updated README from master HTML file

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
