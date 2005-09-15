Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVIOAhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVIOAhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOAhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:37:48 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:2275 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932495AbVIOAhr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:37:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lymHd4ixyKf5Rg8O0VdkjU/vH3VLHUEK8+mGzRmu+KrzyPJfFkyGcWofIyDfO8T0oJV3xLzwbcs0qqHwV9WRc+V/xdgHOAiOrXwgwyYMOXWFgozXoTBFPiakHCJZu/H3wJaBPSvuiN3QvRYrujYxaRQAbXU+T5TICiLcVx/wcXs=
Message-ID: <924c288305091417375fea4ec2@mail.gmail.com>
Date: Wed, 14 Sep 2005 17:37:41 -0700
From: Hua Zhong <hzhong@gmail.com>
Reply-To: hzhong@gmail.com
To: marekw1977@yahoo.com.au
Subject: Re: Automatic Configuration of a Kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509151009.59981.marekw1977@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
	 <6bffcb0e05091415533d563c5a@mail.gmail.com>
	 <4328B710.5080503@in.tum.de>
	 <200509151009.59981.marekw1977@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I concur.

There seems to be a trend that discourages normal users from running
kernel.org kernels, but I rarely find myself agree with such mind set.
Do we want more people to test vanilla kernels or not?

On 9/14/05, Marek W <marekw1977@yahoo.com.au> wrote:
> On Thu, 15 Sep 2005 09:49, Daniel Thaler wrote:
> > Michal Piotrowski wrote:
> > > Hi,
> > >
> > > On 15/09/05, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com> wrote:
> > >>Hi
> > >>
> > >>I wrote this Framework for making a .config based on
> > >>the System Hardwares. It would be a great help if some
> > >>people would give me their opinion about it.
> > >>
> > >>Regards
> > >
> > > It's for new linux users? They should use distributions kernels.
> > > It's for "power users"? They just do make menuconfig...
> > > It's for kernel developers? They just do vi .config.
> >
> > I like the idea.
> > I'm a power user and of course I can do make menuconfig, but it would be
> > useful when building a kernel for new hardware for example.
> >
> > Currently that involves looking at dmesg output to figure out the correct
> > options; this would provide a nice base config to work with and reduce the
> > amount of effort.
> 
> I second that. Unlike majority of users I suppose, I upgrade the kernel often
> and I am on the bleeding edge (laptop user with some drivers still being in
> development). Even with oldconfig it's easy to miss a useful driver
> (sometimes there's no help or the volume of new options is too large).
> 
> Something that can do the hardware detection, then maps that to drivers would
> be very useful.
> 
> 
> --
> 
> Marek W
> Send instant messages to your online friends http://au.messenger.yahoo.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
