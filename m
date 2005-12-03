Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbVLCVM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVLCVM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVLCVM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:12:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:9176 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750985AbVLCVM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:12:26 -0500
Date: Sat, 3 Dec 2005 13:12:09 -0800
From: Greg KH <greg@kroah.com>
To: "M." <vo.sinh@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203211209.GA4937@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<dragging the converstation back to lkml, where it belongs...>

On Sat, Dec 03, 2005 at 09:54:35PM +0100, M. wrote:
> On 12/3/05, Greg KH <greg@kroah.com> wrote:
> > On Sat, Dec 03, 2005 at 03:29:54PM +0100, Jesper Juhl wrote:
> > >
> > > Why can't this be done by distributors/vendors?
> >
> > It already is done by these people, look at the "enterprise" Linux
> > distributions and their 5 years of maintance (or whatever the number
> > is.)
> >
> > If people/customers want stability, they already have this option.
> >
> > thanks,
> >
> > greg k-h
> 
> Yes but not home users with relatively new/bleeding edge hardware or
> small projects writing for example a wifi driver or a security patch
> or whatever without full time commitment to tracking kernel changes.

If you are a user that wants this kind of support, then use a distro
that can handle this.  Obvious examples that come to mind are both
Debian and Gentoo and Fedora and OpenSuSE, and I'm sure there are
others.

But if you are a developer, you can usually stay up to date by tracking
the main releases, which should be about once a month.  If you have
problems porting your stuff to the latest kernel when you need to submit
it for inclusion, there are lots of people to help point you in the
proper direction for what is needed to be done.

> Enterprise products are suited for production servers,
> school/government/companies desktops and not for "enthusiasts" or for
> small kernel projects (they obviously cant write drivers or patches
> for custom distro kernels). Those enthusiasts have to get mad with
> performance regressions, new incompatibilities, new crashes etc.

Sure, then use a different distro for them.  That's why Linux has so
many different ones, they all are targeted at different users.

thanks,

greg k-h
