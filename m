Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVKOGbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVKOGbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 01:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVKOGbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 01:31:09 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:33884 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932305AbVKOGbI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 01:31:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dziSVENJCEfZdnZW5x3RNWBbWCOV5tdzp3PkpBNasWz2Czw10diMBB+3hZDA2yOrz3M6jdmXforRX5P67HMUFzVhg1iY5jngPvMiU5wHL/i5Rick5L6hFoK/DuIHVVFKuTKOs6TAib/Kr0B5uAWWXakwwdxaV8IPqkiGii47p8o=
Message-ID: <2cd57c900511142231r17818338s@mail.gmail.com>
Date: Tue, 15 Nov 2005 14:31:06 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] HOWTO do Linux kernel development
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051115055229.GA6163@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114220709.GA5234@kroah.com>
	 <2cd57c900511141708y5d11fd34n@mail.gmail.com>
	 <20051115043846.GA28005@kroah.com>
	 <2cd57c900511142151h7d8f97b3p@mail.gmail.com>
	 <20051115055229.GA6163@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/15, Greg KH <greg@kroah.com>:
> On Tue, Nov 15, 2005 at 01:51:44PM +0800, Coywolf Qi Hunt wrote:
> > 2005/11/15, Greg KH <greg@kroah.com>:
> > > On Tue, Nov 15, 2005 at 09:08:30AM +0800, Coywolf Qi Hunt wrote:
> > > > 2005/11/15, Greg KH <gregkh@suse.de>:
> > > > > So, I've been working on a document for the past week or so to help
> > > > > alleviate a lot of these problems.  If nothing else, it should be a place
> > > > > where anyone can point someone to when they ask the common questions, or
> > > > > do something in the not-correct way.  I'd like to add this to the Linux
> > > > > kernel source tree, so it will be kept up to date over time, as things
> > > > > change (like the development process.)  Ideally I'd like to put it in
> > > > > the main directory as HOWTO, but I don't know how others feel about
> > > >
> > > > You put it in the top directory to draw the most attention? Compare to
> > > > source trees of other kernel projects, Linux source tree looks clean.
> > > > Please don't spoil that. What's wrong with Documentation/ ?
> > >
> > > People do not seem to even realize Documentation/ is there :(
> >
> > Those who don't notice Documentation, don't deserve it, and are not
> > likely/willingly to be the audience,
>
> Actually this is exactly the audience this is for, people who do not
> know where to look for the stuff they are trying to find.
>
> Now getting people to realize that this is the file they really want to
> look at is a different task, but not impossible.

Seriously doubt it. Or even they find the howto in top directory, they
aren't going to persevere in finishing reading it. So please keep it
as short as possible to full achieve your goal.

>
> > > Now if those same people would notice anything in the root directory
> > > either, is another story...
> >
> > That is rather like top-posting or CAPITALIZATION, or spamming.
>
> Cool, I'm a top-poster, SPAMMER for creating a HOWTO file in the root
> directory of the kernel tree.  And here I thought I had been called
> every bad name in the book before :)

np then, I've done my job as a reminder.
btw, also remember to add there a
tutorial-for-dummies-step-by-step-in-ten-days and the like.

>
> > > It's just a suggestion.
> >
> > We are unlikely to relocate files. So if it gets there, it'll stay
> > there all along.
>
> git makes it trivial to move files, so this is not true at all.

I mean we are unlikely/lazy to do relocation. So it's a
once-wrong-always-wrong thing.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
