Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbVKPCRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbVKPCRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 21:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVKPCRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 21:17:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47621 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965181AbVKPCRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 21:17:54 -0500
Date: Wed, 16 Nov 2005 03:17:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Message-ID: <20051116021754.GM5735@stusta.de>
References: <20051115210459.GA11363@kroah.com> <20051116002348.GL5735@stusta.de> <20051116011032.GA16604@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116011032.GA16604@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 05:10:32PM -0800, Greg KH wrote:
> On Wed, Nov 16, 2005 at 01:23:48AM +0100, Adrian Bunk wrote:
>...
> > LDD (as you might have heard, it's also available online for free ;-) )
> > and the book by Robert Love are good starting points for learning kernel 
> > programming, and they should IMHO be listed here.
> 
> But that's what the Documentation/kernel-docs.txt file has in it.  I

It seems you haven't looked at kernel-docs.txt before saying this...

kernel-docs.txt is so heavily outdated we should better remove it.

> don't want to get into judging which kernel books go into this file, as
> people might think I am a bit biased :)

Judging from the questions I see from newbies on linux-kernel (who 
should be the target audience of your document), you are omitting the 
answer to the most frequently asked question.

I'd say noone disagrees that LDD and the book by Robert Love are the 
books mentioned most often (and by different kernel developers) when 
people ask which book to read as introduction for kernel hacking.

>...
> > >...
> > > Becoming A Kernel Developer
> > > ---------------------------
> > >...
> > > If you already have a chunk of code that you want to put into the kernel
> > > tree, but need some help getting it in the proper form, the
> > > kernel-mentors project was created to help you out with this.  It is a
> > > mailing list, and can be found at:
> > > 	http://selenic.com/mailman/listinfo/kernel-mentors
> > 
> > 
> > This list seems to be nearly dead, and it seems the following one is now 
> > used instead:
> >    http://mail.nl.linux.org/kernelnewbies/
> 
> I do mention the kernelnewbies project, which includes the mailing list.
> I hope the mentor's project picks up, I just think not enough people
> realize it is there.
>...

It's perhaps a bit out of the scope of this discussion, but do we really 
need both of these lists? I don't see any real difference between them.

I'd say one of them is enough, or perhaps replace them with one at 
kernel.org?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

