Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbRCBPxz>; Fri, 2 Mar 2001 10:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129276AbRCBPxp>; Fri, 2 Mar 2001 10:53:45 -0500
Received: from ausxc08.us.dell.com ([143.166.99.216]:40719 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S129270AbRCBPxb>; Fri, 2 Mar 2001 10:53:31 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9DED@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-aacraid-devel@domsch.com, linux-aacraid-announce@domsch.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Final aacraid driver for 2.2.x and 2.4.x
Date: Fri, 2 Mar 2001 09:50:48 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The final aacraid driver for Linux kernels 2.2.x and 2.4.x are now posted at
http://domsch.com/linux.

Changes from aacraid v1.0.7 for 2.2.x are in PERCID_add.patch:
- MAINTAINERS file update
- PCI ID update

Changes from aacraid beta for 2.4.x include:
- MAINTAINERS file update
- PCI ID update
- No longer calling this "beta".  Extensive testing over the past several
weeks have not uncovered any driver issues.

Distributions, if you're including aacraid support, please update your
kernels accordingly.  This driver supports the on-board RAID controllers on
the Dell PowerEdge 2400, 2450, and 4400 servers, the add-in 4-channel PERC2
card, and the HP NetRAID-4M card.

Please join linux-aacraid-devel@domsch.com to discuss this driver, or
linux-aacraid-announce@domsch.com to receive future announcements.
Information about both lists can be found at http://domsch.com/linux.

Special thanks to Jens Axboe for providing the request-size-limiting patch,
to Brian Boerner as the main developer of this driver for the past year, and
to Adaptec for their continued development support.

Thanks,
Matt

--
Matt Domsch
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux

