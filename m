Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbTGEWkL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 18:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266528AbTGEWkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 18:40:11 -0400
Received: from mail.netapps.org ([12.162.17.40]:24395 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266527AbTGEWkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 18:40:09 -0400
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Sipek <jeffpc@optonline.net>, Jeff Garzik <jgarzik@pobox.com>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, netdev@oss.sgi.com
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
References: <E19YtAq-0006Xf-00@calista.inka.de>
	<200307051637.52252.jeffpc@optonline.net> <3F0737D1.5090109@pobox.com>
	<200307051700.32533.jeffpc@optonline.net>
	<20030705235131.A10511@electric-eye.fr.zoreil.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 05 Jul 2003 15:54:15 -0700
In-Reply-To: <20030705235131.A10511@electric-eye.fr.zoreil.com>
Message-ID: <52r85437qg.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Jul 2003 22:54:17.0964 (UTC) FILETIME=[5D5DCAC0:01C34348]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Francois> - the PCI bus don't/won't/can't handle multiple 10 Gb/s adapters

In a year, there will be 32-bit x86 systems with multiple 8X PCI
Express slots (16 Gb/sec full duplex to each slot).  In five years,
those systems will sell for $10 on Ebay.

 - Roland
