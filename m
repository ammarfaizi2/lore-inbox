Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVLCWsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVLCWsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVLCWsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:48:33 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:22179 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751299AbVLCWsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:48:32 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051203222946.GB2863@kroah.com>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620598.22170.14.camel@laptopd505.fenrus.org>
	 <20051203152339.GK31395@stusta.de>
	 <20051203162755.GA31405@merlin.emma.line.org>
	 <4391CEC7.30905@unsolicited.net>
	 <1133630012.6724.7.camel@localhost.localdomain>
	 <4391D335.7040008@unsolicited.net>
	 <20051203222138.GA25722@merlin.emma.line.org>
	 <20051203222946.GB2863@kroah.com>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 17:48:27 -0500
Message-Id: <1133650107.6724.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 14:29 -0800, Greg KH wrote:
> On Sat, Dec 03, 2005 at 11:21:38PM +0100, Matthias Andree wrote:
> > On Sat, 03 Dec 2005, David Ranson wrote:
> > 
> > > Steven Rostedt wrote:
> > > 
> > > >udev ;)
> > > >
> > > >http://seclists.org/lists/linux-kernel/2005/Dec/0180.html
> > > >
> > > >
> > > Ahh OK .. I don't use it, so wouldn't have been affected. That's one
> > > userspace interface broken during the series, does anyone have any more?
> > 
> > Not only that, udev is default for instance in recent SUSE Linux
> > releases, so whether to use or not to use it is a major effort.
> 
> And if you use SUSE releases, use OpenSuSE to keep up to date with all
> of the needed kernel programs for the latest kernels.  Same with Fedora,
> Debian, or Gentoo.  They all keep up to date quite well.

And if you use Debian, make sure you remember to do an update after
changing a kernel and finding out that something in userland doesn't
work.  As Greg mentioned to me in the above mentioned thread.
Debian/unstable had the proper udev.  I just haven't done an update
recently, but I download kernels practically every day.

-- Steve


