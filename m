Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277849AbRJIRMZ>; Tue, 9 Oct 2001 13:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277851AbRJIRMP>; Tue, 9 Oct 2001 13:12:15 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16786 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277849AbRJIRMJ>; Tue, 9 Oct 2001 13:12:09 -0400
Date: Tue, 9 Oct 2001 11:11:50 -0600
Message-Id: <200110091711.f99HBoe30168@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v195 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 195 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.11-pre6. Highlights of this release:

- Fixed buffer underrun in <try_modload>

- Moved down_read() from <search_for_entry_in_dir> to <find_entry>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
