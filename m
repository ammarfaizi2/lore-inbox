Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965420AbWJBVje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965420AbWJBVje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965422AbWJBVje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:39:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15071 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965420AbWJBVjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:39:33 -0400
Subject: Re: [PATCH] ISDN: mark as 32-bit only
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Miller <davem@davemloft.net>
Cc: jeff@garzik.org, jengelh@linux01.gwdg.de, kkeil@suse.de,
       kai.germaschewski@gmx.de, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061002.133715.63105344.davem@davemloft.net>
References: <20061001152116.GA4684@havoc.gtf.org>
	 <Pine.LNX.4.61.0610012007240.13920@yvahk01.tjqt.qr>
	 <45208D82.8010606@garzik.org>
	 <20061002.133715.63105344.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 23:04:05 +0100
Message-Id: <1159826645.8907.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 13:37 -0700, ysgrifennodd David Miller:
> I totally agree with Jeff.  The ISDN layer is effectively unmaintained
> and the vast majority of the ISDN work that does actually occur is
> done out-of-tree.

There are big chunks this is not true for. Also it work son x86-64
correctly, Jeff is barking up the wrong tree altogether.

Alan
