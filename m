Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUDDVjl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 17:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbUDDVjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 17:39:41 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:43013 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261248AbUDDVjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 17:39:40 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: No interrupts for PCMCIA cards
Date: Sun, 4 Apr 2004 23:38:47 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404042338.47368.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you can try my TI interrupt routing patch:
	http://ritz.dnsalias.org/linux/pcmcia-ti-routing-9.patch
also included in	2.6.5-rc3-mm1 and higher:
	http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6.5-rc3-mm4/broken-out/yenta-TI-irq-routing-fix.patch

also the dmesg output with my patch applied would be nice to see...

rgds
-daniel

