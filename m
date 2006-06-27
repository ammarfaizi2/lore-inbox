Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161229AbWF0Rzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbWF0Rzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161232AbWF0Rzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:55:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46600 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161229AbWF0Rza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:55:30 -0400
Date: Tue, 27 Jun 2006 19:55:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: wfg@mail.ustc.edu.cn, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm3: no help text for READAHEAD_ALLOW_OVERHEADS
Message-ID: <20060627175529.GC13915@stusta.de>
References: <20060627015211.ce480da6.akpm@osdl.org> <20060627091429.GK23314@stusta.de> <20060627134337.GA6117@mail.ustc.edu.cn> <20060627144019.GA13915@stusta.de> <20060627104649.25832e61.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627104649.25832e61.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 10:46:49AM -0700, Randy.Dunlap wrote:
> On Tue, 27 Jun 2006 16:40:19 +0200 Adrian Bunk wrote:
> 
> > On Tue, Jun 27, 2006 at 09:43:37PM +0800, Wu Fengguang wrote: ...
> > > > Additionally, the "default n" is pointless and should be removed.
> > > 
> > > I expect the _extra_ features are useless for normal users.
> > > Your reasoning or feeling?
> > >...
> > 
> > That's not my point, my point is that if you remove the "default n" 
> > line, nothing changes. The default is still "n", but it's better 
> > readable.
> 
> Why is it more readable without the "default n" line?
> One could say that supplying the default "default n" line is clearer
> than having it omitted.

The majority of options defaults to "n".

It's easier to spot a non-"n" default if this means an additional line 
instead of only one changed letter.

> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

