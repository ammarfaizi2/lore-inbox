Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284775AbRLDAU4>; Mon, 3 Dec 2001 19:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284793AbRLDAQx>; Mon, 3 Dec 2001 19:16:53 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:20672 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284935AbRLCSfc>; Mon, 3 Dec 2001 13:35:32 -0500
Date: Mon, 3 Dec 2001 11:34:57 -0700
Message-Id: <200112031834.fB3IYvg23052@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.2 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.2 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.17-pre2. Highlights of this release:

- Fixed bug in <devfsd_close>: was dereferencing freed pointer

- Added process group check for devfsd privileges

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
