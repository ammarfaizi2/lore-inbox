Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbULUMAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbULUMAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 07:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbULUMAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 07:00:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40465 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261742AbULUMAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 07:00:13 -0500
Date: Tue, 21 Dec 2004 13:00:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arne Caspari <arnem@informatik.uni-bremen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Collins <bcollins@debian.org>,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041221120012.GC5217@stusta.de>
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de> <20041220143901.GD457@phunnypharm.org> <1103555716.29968.27.camel@localhost.localdomain> <20041220154638.GE457@phunnypharm.org> <1103573716.31512.10.camel@localhost.localdomain> <41C7DFE9.5070604@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C7DFE9.5070604@informatik.uni-bremen.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 09:33:45AM +0100, Arne Caspari wrote:
>...
> I would take it like in a library: The API should not change between 
> minor versions - likewise it should be stable in the kernel among all 
> 2.6.x versions. If it changes to version 2.7.x or 2.8.x it would be OK 
> since we could release a driver for a 2.8.x tree then.

The current development model published by Linus Torvalds and
Andrew Morton is that there will be no 2.7.x in the forseeable future, 
but instead the changes that would go into a 2.7 series go into the 2.6 
series...

>  /Arne

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

