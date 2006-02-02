Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWBBPnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWBBPnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWBBPnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:43:18 -0500
Received: from vmaila.mclink.it ([195.110.128.108]:34827 "EHLO
	vmaila.mclink.it") by vger.kernel.org with ESMTP id S932081AbWBBPnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:43:17 -0500
From: "Mauro Tassinari" <mtassinari@cmanet.it>
To: "'Dave Airlie'" <airlied@gmail.com>
Cc: "'Pekka Enberg'" <penberg@cs.helsinki.fi>, <linux-kernel@vger.kernel.org>
Subject: R: R: Xorg crashes 2.6.16-rc1-git4
Date: Thu, 2 Feb 2006 16:42:31 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAArZ0pklNthUuckKZlAHDrBgEAAAAA@cmanet.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <21d7e9970602020148r52476d7eh32e0d0ed44b598c5@mail.gmail.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Can you disable DRI in xorg.conf? remove the Load "dri" line.
> 
> X probably shouldn't enable dri by default on r300..
> 
> Dave.
>

DRI disabled makes X work.

BTW, 2.6.15 works with DRI enabled.

New pci express support?

Mauro



