Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbULRCGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbULRCGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 21:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbULRCGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 21:06:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32775 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262813AbULRCGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 21:06:38 -0500
Date: Sat, 18 Dec 2004 03:06:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] SCSI aic7xxx: kill kernel 2.2 #ifdef's (fwd)
Message-ID: <20041218020635.GJ21288@stusta.de>
References: <20041216221802.GT12937@stusta.de> <41C2147D.1090603@osdl.org> <1103239700.21806.40.camel@localhost.localdomain> <41C23458.1080404@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C23458.1080404@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 05:20:24PM -0800, Randy.Dunlap wrote:
> Alan Cox wrote:
> >>I would really appreciate it if you could limit patches for major
> >>subsystems to only the mailing list for those subsystems.
> >
> >
> >And then I'd have missed the lapb error for example. At least for less
> >maintained stuff do use this list
> 
> netdev is _the_ mailing list for network-related development...
> 
> scsi should happen on linux-scsi
> 
> If we take your argument to an extreme, we only need
> one mailing list.  :(

It does make sense:

If you are _only_ interested in SCSI related development, linux-scsi is 
a good choice and a relatively low-volume list.

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

