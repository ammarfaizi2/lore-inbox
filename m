Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbTIBKWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbTIBKWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:22:35 -0400
Received: from 3E6B2019.rev.stofanet.dk ([62.107.32.25]:8324 "EHLO sysrq.dk")
	by vger.kernel.org with ESMTP id S263641AbTIBKWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:22:33 -0400
Subject: Airo Net 340 PCMCIA WiFi Card trouble
From: Martin Willemoes Hansen <mwh@sysrq.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062498150.356.9.camel@spiril.sysrq.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Sep 2003 12:22:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Im getting an error when using my Airo PCMCIA WiFi card with the
2.4.20, 2.4.21, 2.4.22 kernel. 
It works when im using 2.4.19 and lower.

The error message:
cardmgr[19]: starting, version is 3.2.4
cs: memory probe 0x0c0000-0x0ffff: excluding 0xc0000-0xcbfff

After looking a bit at the mailinglist archive I see that there is some
trouble with the Airo drivers. Will there be a fix for the 2.4.x series?
Will it be fixed out of the box in 2.6.x?

I hope you can help.

The card im using is a Cisco Airo Net 340

PS. Im not subscribed to this list, so please reply to my email address.

PPS. Happy hacking!
-- 
Martin Willemoes Hansen

--------------------------------------------------------
E-Mail	mwh@sysrq.dk	Website	mwh.sysrq.dk
IRC     MWH, freenode.net	
--------------------------------------------------------              

