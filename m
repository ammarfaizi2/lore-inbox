Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbTEJF4q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 01:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbTEJF4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 01:56:46 -0400
Received: from granite.he.net ([216.218.226.66]:61713 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263663AbTEJF4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 01:56:45 -0400
Date: Fri, 9 May 2003 23:11:14 -0700
From: Greg KH <greg@kroah.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       David Brownell <david-b@pacbell.net>,
       Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Message-ID: <20030510061113.GA2881@kroah.com>
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com> <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com> <3EBBFC33.7050702@pacbell.net> <1052517124.10458.199.camel@localhost.localdomain> <20030509230542.GA3267@kroah.com> <3EBC4C50.8040304@pacbell.net> <20030510054015.GA1865@kroah.com> <20030510055516.GD8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510055516.GD8978@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 10:55:16PM -0700, William Lee Irwin III wrote:
> On Fri, May 09, 2003 at 05:48:16PM -0700, David Brownell wrote:
> >> "u32" is prettier, but is there actually a policy against using
> >> the more standard type names?  (POSIX, someone had said.)
> 
> On Fri, May 09, 2003 at 10:40:15PM -0700, Greg KH wrote:
> > Yes there is.  Linus has stated this a few times on lkml in the past.  I
> > have an old linux journal article that talks about this that I need to
> > turn into docbook and add to the kernel tree to set it in stone.
> 
> If someone could clarify the motive I'd be much obliged.

Read Linus's comments in this thread for more insight:
	http://marc.theaimsgroup.com/?t=102806382900001

Hope this helps,

greg k-h
