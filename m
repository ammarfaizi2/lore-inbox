Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264899AbSJPFka>; Wed, 16 Oct 2002 01:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264900AbSJPFka>; Wed, 16 Oct 2002 01:40:30 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:58278 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S264899AbSJPFk3>; Wed, 16 Oct 2002 01:40:29 -0400
Date: Tue, 15 Oct 2002 23:46:19 -0600
Message-Id: <200210160546.g9G5kJm18075@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v218 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 218 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.43. Highlights of this release:

- Removed DEVFS_FL_AUTO_OWNER flag

- Switched lingering structure field initialiser to ISO C

- Added locking when setting/clearing flags

- Documentation fix in fs/devfs/util.c

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
