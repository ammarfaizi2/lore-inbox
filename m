Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270386AbTG1SSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270391AbTG1SSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:18:11 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:11230 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S270386AbTG1SSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:18:04 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <linux-kernel@vger.kernel.org>
Subject: DMA not supported with Intel ICH4 I/O controller?
Date: Mon, 28 Jul 2003 14:44:46 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGCEIHCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just read on an Intel site
(http://64.143.3.64/downloads/drivers/845/perform/linux/udma.htmthat) "ICH4
requires kernel 2.5.12 or later to enable any DMA mode".  Can you guys
support or refute this?  No wonder I'm having problems with my DMA device on
the ASUS P4PE (using Intel 845PE and ICH4 chipsets)!  Are there any patches,
by chance, against a 2.4.20-8 that will give our system DMA support?  Or
maybe a patch for 2.4.21?  kernel.org shows that the latest (albeit beta)
kernel is 2.6.0-test2 . . . I hestiate to use that, because we would like
something more stable to ship with our product.

Thanks,

Kathy Frazier
Senior Software Engineer
Max Daetwyler Corporation-Dayton Division
2133 Lyons Road
Miamisburg, OH 45342
Tel #: 937.439-1582 ext 6158
Fax #: 937.439-1592
Email: kfrazier@daetwyler.com
http://www.daetwyler.com



