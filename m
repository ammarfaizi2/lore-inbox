Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318333AbSGYFf4>; Thu, 25 Jul 2002 01:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318338AbSGYFf4>; Thu, 25 Jul 2002 01:35:56 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:25486 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S318333AbSGYFfx>; Thu, 25 Jul 2002 01:35:53 -0400
Date: Wed, 24 Jul 2002 23:38:43 -0600
Message-Id: <200207250538.g6P5chV29917@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.15 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.15 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.19-rc3. Highlights of this release:

- Switched to ISO C structure field initialisers

- Switch to set_current_state() and move before add_wait_queue()

- Updated README from master HTML file

- Fixed devfs entry leak in <devfs_readdir> when *readdir fails

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
