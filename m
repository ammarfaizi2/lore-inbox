Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbULTAWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbULTAWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 19:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbULTAWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 19:22:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59660 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261358AbULTAWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 19:22:31 -0500
Date: Mon, 20 Dec 2004 01:22:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Armin Schindler <armin@melware.de>
Cc: isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       developers@melware.de
Subject: Re: RFC: [2.6 patch] Eicon: disable debuglib for modules
Message-ID: <20041220002225.GJ21288@stusta.de>
References: <20041030072256.GH4374@stusta.de> <Pine.LNX.4.31.0410301343450.24225-100000@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0410301343450.24225-100000@phoenix.one.melware.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there a good reason why debuglib is enabled for modules?
> 
> Yes.
> Without it, there would be no possibility to use the maintainance module
> to debug the isdn/card/capi interaction.
> 
> > If not, I'd propose the patch below to disable it.
> 
> I have to disagree. This patch would disable a major feature of the
> diva driver collection.

How do I enable this maintainance module in the kernel?

> Armin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

