Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264869AbSJPFHc>; Wed, 16 Oct 2002 01:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264871AbSJPFHc>; Wed, 16 Oct 2002 01:07:32 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43430 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S264869AbSJPFHb>; Wed, 16 Oct 2002 01:07:31 -0400
Date: Tue, 15 Oct 2002 23:13:00 -0600
Message-Id: <200210160513.g9G5D0M15828@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.17 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.17 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.20-pre11. Highlights of this release:

- Updated README from master HTML file

- Switched lingering structure field initialiser to ISO C

- Added locking when setting/clearing flags

- Documentation fix in fs/devfs/util.c

- Created <devfs_find_and_unregister>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
