Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276010AbRJBRHN>; Tue, 2 Oct 2001 13:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276000AbRJBRHC>; Tue, 2 Oct 2001 13:07:02 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:39147 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S275972AbRJBRGx>; Tue, 2 Oct 2001 13:06:53 -0400
Date: Tue, 2 Oct 2001 11:03:20 -0600
Message-Id: <200110021703.f92H3Ki07831@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v193 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 193 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.10. Highlights of this release:

- Went back to global rwsem for symlinks (refcount scheme no good)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
