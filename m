Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUBSLgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 06:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267207AbUBSLgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 06:36:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:29099 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267205AbUBSLgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 06:36:16 -0500
Date: Thu, 19 Feb 2004 03:36:15 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402191136.i1JBaFKA009781@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.3 - 2004-02-18.22.30) - 4 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/isdn/capi/capidrv.c:2111:10: warning: #warning FIXME: maybe a race condition the card should be removed here from global list /kkeil
drivers/isdn/hisax/config.c:1889: warning: `hisax_pci_tbl' defined but not used
drivers/isdn/icn/icn.c:719:18: warning: #warning TODO test headroom or use skb->nb to flag ACK
drivers/net/dgrs.c:1463: warning: `dev' might be used uninitialized in this function
