Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVCIPgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVCIPgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVCIPgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:36:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:58077 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261617AbVCIPgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:36:10 -0500
Date: Wed, 9 Mar 2005 07:35:48 -0800
From: Greg KH <greg@kroah.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: Dominik Karall <dominik.karall@gmx.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       chrisw@osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.11.2
Message-ID: <20050309153548.GA23096@kroah.com>
References: <20050309083923.GA20461@kroah.com> <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt> <Pine.LNX.4.62.0503091104180.22598@numbat.sonytel.be> <200503091121.16801.dominik.karall@gmx.net> <Pine.LNX.4.61.0503091023410.7496@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503091023410.7496@student.dei.uc.pt>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 10:28:32AM +0000, Marcos D. Marado Torres wrote:
> On Wed, 9 Mar 2005, Dominik Karall wrote:
> 
> >>>> which is a patch against the 2.6.11.1 release.  If consensus arrives
> >>>> that this patch should be against the 2.6.11 tree, it will be done that
> >>>> way in the future.
> >>>
> >>> IMHO it sould be against 2.6.11 and not 2.6.11.1, like -rc's that are'nt
> >>> againt
> >>> the last -rc but against 2.6.x.
> >>
> >> It's a stable release, not a pre/rc, so against 2.6.11.1 sounds most
> >> logical to me.
> >
> > I don't think so. The latest patch (2.6.11.2 now) is on the frontpage of
> > kernel.org, so IMHO the user should not need to search the kernel.org/pub
> > archives to get 2.6.11.1 patch before he can start working with 2.6.11.2.
> >
> > I think it's a small problem too, that 2.6.11 source isn't directly accessable
> > through the kernel.org frontpage while there is no "full tarball" of 2.6.11.X
> > trees.
> 
> With that "full tarball" for 2.6.11.X the issues would be over.
> I think there should be one.

There is one, did you not look?

	kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.2.tar.gz

thanks,

greg k-h
