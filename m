Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318330AbSGYFgh>; Thu, 25 Jul 2002 01:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318329AbSGYFgh>; Thu, 25 Jul 2002 01:36:37 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:27022 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S318330AbSGYFgf>; Thu, 25 Jul 2002 01:36:35 -0400
Date: Wed, 24 Jul 2002 23:39:46 -0600
Message-Id: <200207250539.g6P5dkU29950@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v214 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 214 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.27. Highlights of this release:

- Switched to ISO C structure field initialisers

- Switch to set_current_state() and move before add_wait_queue()

- Updated README from master HTML file

- Fixed devfs entry leak in <devfs_readdir> when *readdir fails

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
