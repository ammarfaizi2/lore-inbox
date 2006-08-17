Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWHQEsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWHQEsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 00:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWHQEsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 00:48:05 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:63138 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S932273AbWHQEsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 00:48:01 -0400
Date: Thu, 17 Aug 2006 04:48:19 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jes@trained-monkey.org,
       netdev@vger.kernel.org, davem@davemloft.net, tglx@linutronix.de,
       Eric.Moore@lsil.com, linux-scsi@vger.kernel.org, mikep@linuxtr.net,
       xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: [RFC][PATCH 0/8] [RFC][PATCH 0/8] Removal of old code
Message-ID: <20060817044819.0.oIvGvh2320.2316.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patches have been tested with allmodconfig and allmodconfig.

drivers/message/fusion/linux_compat.h |    9 -----
drivers/mtd/nand/au1550nd.c           |   11 ------
drivers/net/acenic.c                  |    4 --
drivers/net/irda/vlsi_ir.h            |   17 ---------
drivers/net/tokenring/lanstreamer.c   |   59 ----------------------------------
drivers/net/tokenring/lanstreamer.h   |   12 ------
drivers/net/typhoon.c                 |    4 --
fs/xfs/xfs_dmapi.h                    |   17 ---------
8 files changed, 1 insertion(+), 132 deletions(-)

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
