Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWATXou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWATXou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWATXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:44:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57106 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750701AbWATXou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:44:50 -0500
Date: Sat, 21 Jan 2006 00:44:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, alan@lxorguk.ukuu.org.uk,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch removed from -mm tree
Message-ID: <20060120234449.GE31803@stusta.de>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net> <1137648119.30084.94.camel@localhost.localdomain> <20060119171708.7f856b42.sfr@canb.auug.org.au> <1137664692.8471.21.camel@localhost.localdomain> <20060119155933.GX4213@suse.de> <1137745995.30084.201.camel@localhost.localdomain> <20060120004456.190f451b.akpm@osdl.org> <1137747595.30084.215.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137747595.30084.215.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 09:59:54PM +1300, David Woodhouse wrote:
> On Fri, 2006-01-20 at 00:44 -0800, Andrew Morton wrote:
> > Oh crap.  The damn thing wraps into column _1_ and gets tangled up with
> > ifdef statements, function definitions and other things which _should_ go
> > in column one.
> 
> It does that only for people with editors which wrap stuff like that
> into column 1. Those people (which includes myself on some occasions)
> are _used_ to seeing stuff like that in column 1, so it's natural. And
> it's text which is of little importance; not something which has much
> relevance to the code flow.
>...

Patches with lines > 80 are not easily readable in 80 column xterms no 
matter whether the lines are wrapped or not.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

