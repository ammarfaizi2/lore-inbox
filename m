Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUJHXQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUJHXQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 19:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUJHXOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 19:14:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:17847 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266128AbUJHXOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 19:14:16 -0400
Date: Fri, 8 Oct 2004 16:13:07 -0700
From: Greg KH <greg@kroah.com>
To: "Eric W. Biederman" <ebiederman@lnxi.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
Message-ID: <20041008231307.GA32530@kroah.com>
References: <20041008202247.GA9653@kroah.com> <m3d5zs966r.fsf@maxwell.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d5zs966r.fsf@maxwell.lnxi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 04:49:16PM -0600, Eric W. Biederman wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > [2] Sure, any person who has a copy of the kernel source tree could be a
> > target for any of a zillion other potential claims, nothing new there,
> > but the point here is they are explicitly stating that they will go
> > after non-IBTA members who touch IB code[3].
> 
> Greg I see nothing to back up the idea that IBTA intends to go after
> non-members.  I simply see a disclaimer of warranty, and I see wording
> by your anonymous source that restates a disclaimer of warranty.

All I know is a number of different people, from different companies are
suddenly very worried about this.  The fact that they don't want to
comment on it in public leads me to believe that there is something
behind their fears.

> Until I see something more to back this up I do not see a problem.  In
> fact I see infiniband prices dropping, and competition increasing.
> The drivers off of openib.org look like they are a good start at
> making a sane linux implementation.

It is a good start.  And as all OpenIB members are also IBTA members, I
am asking for the group's position as to this change.

> Even the PCI-SIG requires you to pay for the spec.

I know that, almost all groups do.  Although $9500 does seem a bit steep
for spec prices :)

> I agree it would be suicidally insane for the infiniband trade
> association to go after a linux stack, as it appears that a large
> portion of the infiniband users are currently running linux.

One specific IBTA member has issues with the adaption of Linux, and has
already done one thing to restrict a full IB implementation that would
work on Linux.  And as for insane, have you ever tried to actually read
that spec?  :)

thanks,

greg k-h
