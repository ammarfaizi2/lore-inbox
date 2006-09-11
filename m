Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWIKSMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWIKSMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWIKSMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:12:35 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33805 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932238AbWIKSMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:12:34 -0400
Date: Mon, 11 Sep 2006 20:12:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fix 2.6.18-rc6 IDE breakage, add missing ident needed for	current VIA boards
Message-ID: <20060911181230.GC32694@stusta.de>
References: <1157982307.23085.140.camel@localhost.localdomain> <45056544.8070303@pobox.com> <1157986765.23085.144.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157986765.23085.144.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 03:59:24PM +0100, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 09:31 -0400, ysgrifennodd Jeff Garzik:
>...
> > For the second:
> > * the sata_via PCI ID has been queued for 2.6.19 for quite a while.  I 
> > don't see a hugely pressing need for it to be in 2.6.18, but it's not a 
> > big deal to me.
> 
> Many of the current VIA mainboards have that ID so I would say its
> pressing as it is "out there", and if 2.6.19 is another 2 months away...

Unless I missed the reason why kernel releases will suddenly become more 
frequent, it's another 3 months away...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

