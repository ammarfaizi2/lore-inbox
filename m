Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVKOGGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVKOGGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 01:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVKOGGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 01:06:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:19422 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751356AbVKOGF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 01:05:59 -0500
Date: Mon, 14 Nov 2005 21:52:29 -0800
From: Greg KH <greg@kroah.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] HOWTO do Linux kernel development
Message-ID: <20051115055229.GA6163@kroah.com>
References: <20051114220709.GA5234@kroah.com> <2cd57c900511141708y5d11fd34n@mail.gmail.com> <20051115043846.GA28005@kroah.com> <2cd57c900511142151h7d8f97b3p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900511142151h7d8f97b3p@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 01:51:44PM +0800, Coywolf Qi Hunt wrote:
> 2005/11/15, Greg KH <greg@kroah.com>:
> > On Tue, Nov 15, 2005 at 09:08:30AM +0800, Coywolf Qi Hunt wrote:
> > > 2005/11/15, Greg KH <gregkh@suse.de>:
> > > > So, I've been working on a document for the past week or so to help
> > > > alleviate a lot of these problems.  If nothing else, it should be a place
> > > > where anyone can point someone to when they ask the common questions, or
> > > > do something in the not-correct way.  I'd like to add this to the Linux
> > > > kernel source tree, so it will be kept up to date over time, as things
> > > > change (like the development process.)  Ideally I'd like to put it in
> > > > the main directory as HOWTO, but I don't know how others feel about
> > >
> > > You put it in the top directory to draw the most attention? Compare to
> > > source trees of other kernel projects, Linux source tree looks clean.
> > > Please don't spoil that. What's wrong with Documentation/ ?
> >
> > People do not seem to even realize Documentation/ is there :(
> 
> Those who don't notice Documentation, don't deserve it, and are not
> likely/willingly to be the audience,

Actually this is exactly the audience this is for, people who do not
know where to look for the stuff they are trying to find.

Now getting people to realize that this is the file they really want to
look at is a different task, but not impossible.

> > Now if those same people would notice anything in the root directory
> > either, is another story...
> 
> That is rather like top-posting or CAPITALIZATION, or spamming.

Cool, I'm a top-poster, SPAMMER for creating a HOWTO file in the root
directory of the kernel tree.  And here I thought I had been called
every bad name in the book before :)

> > It's just a suggestion.
> 
> We are unlikely to relocate files. So if it gets there, it'll stay
> there all along.

git makes it trivial to move files, so this is not true at all.

thanks,

greg k-h
