Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315850AbSEMFuS>; Mon, 13 May 2002 01:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315849AbSEMFuR>; Mon, 13 May 2002 01:50:17 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16592 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315850AbSEMFuP>; Mon, 13 May 2002 01:50:15 -0400
Date: Sun, 12 May 2002 23:49:56 -0600
Message-Id: <200205130549.g4D5nus15881@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v213 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 213 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.15. Highlights of this release:

- Protected <scan_dir_for_removable> and <get_removable_partition>
  from changing directory contents

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
