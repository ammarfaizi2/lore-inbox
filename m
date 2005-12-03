Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVLCXaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVLCXaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 18:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVLCXaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 18:30:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:60569 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751302AbVLCXaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 18:30:03 -0500
Date: Sat, 3 Dec 2005 15:28:37 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203232836.GA1496@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <20051203225105.GO31395@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203225105.GO31395@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 11:51:05PM +0100, Adrian Bunk wrote:
> On Sat, Dec 03, 2005 at 12:19:45PM -0800, Greg KH wrote:
> > On Sat, Dec 03, 2005 at 03:29:54PM +0100, Jesper Juhl wrote:
> > > 
> > > Why can't this be done by distributors/vendors?
> > 
> > It already is done by these people, look at the "enterprise" Linux
> > distributions and their 5 years of maintance (or whatever the number
> > is.)
> > 
> > If people/customers want stability, they already have this option.
> 
> I don't get the point where the advantage is when every distribution 
> creates it's own stable branches.

They only do so because they are on different release cycles.

> AFAIR one of the reasons for the current 2.6 development model was to 
> reduce the amount of feature patches distributions ship by offering an 
> ftp.kernel.org kernel that gets new features early.

Sure, that's one of the reasons.  But not the only one by far (I have a
whole list somewhere, I'm sure it's in the archives...)

> What's wrong with offering an unified branch with few regressions for 
> both users and distributions? It's not that every distribution will use 
> it, but as soon as one or two distributions are using it the amount of 
> extra work for maintaining the branch should become pretty low.

"pretty low"?  hahahahaha.  As Arjan has said, the time and energy to do
this for a long period of time is huge.  If I were you, I would listen
to the people who have and do maintain these kinds of kernels, it's not
a simple job by any means.

But by all means, if you want to try to do this, please do.  I wish you
good luck.

thanks,

greg k-h
