Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263958AbSJTKft>; Sun, 20 Oct 2002 06:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSJTKft>; Sun, 20 Oct 2002 06:35:49 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38998 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263958AbSJTKfs>; Sun, 20 Oct 2002 06:35:48 -0400
Date: Sun, 20 Oct 2002 06:35:56 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [LARGE patch 23/124] sets sent over and over again Re: [PATCH] ext2/3 updates for 2.5.44 (1/11): Default mount options in superblock
Message-ID: <20021020063556.A20617@devserv.devel.redhat.com>
References: <E183CUa-0007Yq-00@snap.thunk.org> <1035108575.3130.10.camel@localhost.localdomain> <20021020113135.A25278@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021020113135.A25278@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Oct 20, 2002 at 11:31:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 11:31:35AM +0100, Russell King wrote:
> On Sun, Oct 20, 2002 at 12:09:35PM +0200, Arjan van de Ven wrote:
> > I hereby politely ask EVERYONE who wants to (re)posts large patchsets,
> > to at minimum try to follow something like the following politeness
> > guidelines
> > 
> > 1) Make it ONE thread. Do this by cc or bcc'ing yourself on the mails
> >    and use the reply feature of your mailer to reply each next number of
> >    the set to the previous one. This allows people that use mail/news
> >    readers that can do threading to properly sort it. This is not hard,
> >    and I consider it the least you can do for the people that read lklm.
> 
> It would be nice if someone scripted this - then people will be much more
> likely to follow it.  It should be relatively trivial to script; you
> just need to generate the message id's and add the relevant headers.
> 
> I'd like to question the appropriateness of such a blanket rule.  I agree
> that it is appropriate for patches that are all part of the same area of
> the kernel (eg, ext2fs, ext3fs, trace toolkits, etc)
> 
> However, is it appropriate to make one thread of a small set of unrelated
> patches that touch different, unrelated parts of the kernel?

That I would consider not "one patchkit" personally. And in general people
who have a set of such varying patches don't post [Patch 5/19].... Eg if a
patch makes sense on it's own (and I don't mean just the first
one) I don't think anyone would consider threading it appropriate. The
LTT, ext3, s390, lkcd, ALSA, hotplug (thanks for threading those Gregh!) 
series however are obviously different from that.


> If all you want to do is delete them, I agree it does.  However, that
> doesn't help the sender, who's reason for sending them is to get comments
> from the community.

It's not to "just" delete them. It's to *GROUP* them properly. 

Greetings,
   Arjan van de Ven
