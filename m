Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbVKICTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbVKICTR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 21:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVKICTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 21:19:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:64230 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030502AbVKICTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 21:19:16 -0500
Date: Tue, 8 Nov 2005 18:18:40 -0800
From: Greg KH <greg@kroah.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.14.1
Message-ID: <20051109021840.GB23537@kroah.com>
References: <20051109010729.GA22439@kroah.com> <2cd57c900511081805s3d385110r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900511081805s3d385110r@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 10:05:43AM +0800, Coywolf Qi Hunt wrote:
> 2005/11/9, Greg KH <gregkh@suse.de>:
> > We (the -stable team) are announcing the release of the 2.6.14.1 kernel.
> >
> > The diffstat and short summary of the fixes are below.
> >
> > I'll also be replying to this message with a copy of the patch between
> > 2.6.14 and 2.6.14.1, as it is small enough to do so.
> >
> > The updated 2.6.14.y git tree can be found at:
> >         rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.14.y.git
> > and can be browsed at the normal kernel.org git web browser:
> >         www.kernel.org/git/
> 
> 
> I'd appreciate it that if you would not overwrite the 2.6.14 record on
> the kernel.org page, but add a new record for 2.6.14.y instead. It
> would benefit others too. FYI: http://lkml.org/lkml/2005/10/9/18

Sorry, but I am not in charge of that at all.  Please contact the
kernel.org web masters if you want to discuss this.  And as 2.6.14 now
has a documented security issue, I wouldn't recommend it being displayed
on the kernel.org page anyway.

Tools like ketchup can handle updating to the proper kernel version just
fine if you want to use it, instead of having to rely on web pages :)

thanks,

greg k-h
