Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTFYBMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTFYBKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:10:48 -0400
Received: from user-vc8fdp3.biz.mindspring.com ([216.135.183.35]:23557 "EHLO
	mail.nateng.com") by vger.kernel.org with ESMTP id S263451AbTFYBKg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:10:36 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: mail.nateng.com
Date: Tue, 24 Jun 2003 18:24:20 -0700 (PDT)
From: Sir Ace <chandler@nateng.com>
X-X-Sender: chandler@jordan.eng.nateng.com
To: linux-kernel@vger.kernel.org
Subject: i2c BUG  easy fix?
Message-ID: <Pine.LNX.4.53.0306241821230.596@jordan.eng.nateng.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have 5 vidcapture cards, all of which show up in /proc/pci
Only the first 4 show up in /proc/bus/i2c*

I tried this on 2 completely unidentical systems, and both 2.4.21, and
2.4.20

I verified that all 5 cards are actually good... {before people start
pointing fingers}

Where do I need to start looking to fix it?
