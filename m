Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270576AbRHIUB6>; Thu, 9 Aug 2001 16:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270577AbRHIUBs>; Thu, 9 Aug 2001 16:01:48 -0400
Received: from guestpc.physics.umanitoba.ca ([130.179.72.122]:518 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270576AbRHIUBq>; Thu, 9 Aug 2001 16:01:46 -0400
Date: Thu, 9 Aug 2001 15:01:43 -0500
Message-Id: <200108092001.f79K1hq06187@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@mobilix.ras.ucalgary.ca
Subject: [PATCH] devfs v186 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 186 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.8-pre6. Highlights of this release:

- Fixed race in <devfs_do_symlink> for uni-processor

- Fixed drivers/scsi/sd.h for when CONFIG_SD_MANY=n

- Updated README from master HTML file

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
