Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753700AbWKEN5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbWKEN5v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 08:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWKEN5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 08:57:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34577 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753693AbWKEN5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 08:57:50 -0500
Date: Sun, 5 Nov 2006 14:57:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Lorenz <martin@lorenz.eu.org>, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
Message-ID: <20061105135751.GC5778@stusta.de>
References: <20061105064801.GV13381@stusta.de> <20061105132607.GA14245@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061105132607.GA14245@mellanox.co.il>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 03:26:07PM +0200, Michael S. Tsirkin wrote:
> Quoting r. Adrian Bunk <bunk@stusta.de>:
> > Subject    : ThinkPad T60/X60: lose ACPI events after suspend/resume
> > References : http://lkml.org/lkml/2006/10/10/39
> >              http://lkml.org/lkml/2006/10/4/425
> >              http://lkml.org/lkml/2006/10/16/262
> >              http://bugzilla.kernel.org/show_bug.cgi?id=7408
> >              http://lkml.org/lkml/2006/10/30/251
> >              http://lkml.org/lkml/2006/11/3/244
> > Submitter  : Martin Lorenz <martin@lorenz.eu.org>
> >              "Michael S. Tsirkin" <mst@mellanox.co.il>
> > Status     : problem is being debugged
> 
> Add to that
> http://lkml.org/lkml/2006/11/1/84
> and a patch in
> http://lkml.org/lkml/2006/11/1/294
> 
> I have been running f9dadfa71bc594df09044da61d1c72701121d802 which hs this patch
> for several days now and this issue seem to be fixed.
> 
> I plan to re-test on -rc5 when that's out.

Thanks for this information, unless you'll tell the opposite I'll assume 
your problems are fixed.

Martin, are your problems also fixed in the latest -git?

> MST

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

