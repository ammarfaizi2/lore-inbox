Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWHFAov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWHFAov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 20:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWHFAov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 20:44:51 -0400
Received: from ns1.suse.de ([195.135.220.2]:5788 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751479AbWHFAov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 20:44:51 -0400
Date: Sun, 6 Aug 2006 02:46:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Josh Boyer <jwboyer@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
Message-ID: <20060806004634.GB6455@opteron.random>
References: <20060803204921.GA10935@kroah.com> <625fc13d0608031943m7fb60d1dwb11092fb413f7fc3@mail.gmail.com> <20060804230017.GO25692@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804230017.GO25692@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 01:00:17AM +0200, Adrian Bunk wrote:
> On Thu, Aug 03, 2006 at 09:43:06PM -0500, Josh Boyer wrote:
> > On 8/3/06, Greg KH <greg@kroah.com> wrote:
> > >This is just a notice to everyone that Adrian is going to now be taking
> > >over the 2.6.16-stable kernel branch, for him to maintain for as long as
> > >he wants to.
> > 
> > Adrian, could you provide a bit of rationale as to why you want to do
> > this?  I'm just curious.
> 
> A long-term maintained stable series was missing in the current 
> development model.
> 
> The 2.6 series itself is theoretically a stable series, but the amount 
> of regressions is too big for some users.

Greg is electing new official maintainers, but Greg is doing other
weird things as well:

       http://www.cpushare.com/blog/andrea/article/42/

I'm certainly not happy with you as an official maintainer of a kernel
that could potentially be used by lot of people (I say potentially
because I doubt many would use it) given that recently you claimed to
be happy with ext2, and you discredited the great work of many people
that are testing new features and reporting feedback. I also don't
trust you to act in the interest of all parties involved in the kernel
community (given that most of them are funded by companies filing lots
of US software patents). I don't need to comment on your signature
since that's explicit enough without me needing to add anything.
