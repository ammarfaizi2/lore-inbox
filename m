Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284835AbRLDAUy>; Mon, 3 Dec 2001 19:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284775AbRLDAQs>; Mon, 3 Dec 2001 19:16:48 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22464 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284936AbRLCSiw>; Mon, 3 Dec 2001 13:38:52 -0500
Date: Mon, 3 Dec 2001 11:38:20 -0700
Message-Id: <200112031838.fB3IcKn23184@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v202 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 202 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.1-pre5. Highlights of this release:

- Fixed bug in <devfsd_close>: was dereferencing freed pointer

- Added process group check for devfsd privileges

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
