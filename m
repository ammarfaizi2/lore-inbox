Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313777AbSDPRVI>; Tue, 16 Apr 2002 13:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313778AbSDPRVH>; Tue, 16 Apr 2002 13:21:07 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:35458 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313776AbSDPRVF>; Tue, 16 Apr 2002 13:21:05 -0400
Date: Tue, 16 Apr 2002 11:20:07 -0600
Message-Id: <200204161720.g3GHK7k13708@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.13 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.13 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.19-pre7. Highlights of this release:

- Updated fs/devfs/util.c to fix shift warning on 64 bit machines
  Thanks to Anton Blanchard <anton@samba.org>

- Updated README from master HTML file

- Do not put miscellaneous character devices in /dev/misc if they
  specify their own directory (i.e. contain a '/' character)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
