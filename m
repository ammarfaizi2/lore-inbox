Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTLBCyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 21:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264287AbTLBCyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 21:54:23 -0500
Received: from [64.65.189.210] ([64.65.189.210]:48074 "EHLO
	mail.pacrimopen.com") by vger.kernel.org with ESMTP id S264255AbTLBCyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 21:54:21 -0500
Subject: Re: XFS for 2.4
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: Bryan Whitehead <driver@jpl.nasa.gov>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FCBB790.1030503@jpl.nasa.gov>
References: <20031201062052.GA2022@frodo> <3FCBABD9.70309@fnal.gov>
	 <3FCBB790.1030503@jpl.nasa.gov>
Content-Type: text/plain
Message-Id: <1070333646.1798.10.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Dec 2003 18:54:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-01 at 13:50, Bryan Whitehead wrote:
> I'd like to "third" this request. Have a large amount of data here on 
> XFS with v2.4 kernel.
> 
> Would be nice to be able to use pre-release 2.4 for testing without 
> having to manually hack in XFS paches from SGI for the odd reject...
> 
> Dan Yocum wrote:
> > Marcelo,
> > 
> > We (Fermilab) second this request.  We won't be touching 2.6 until it's 
> > really stable (read as, Red Hat comes out with an official distro that 
> > has it built in), and we already have *a lot* of XFS filesystems here 
> > (~>300TB) running on 2.4 kernels.  It would be very, very nice to have 
> > it in the 2.4 tree without having to pull it from SGI.
> > 
> > Thanks,
> > Dan

I would like to 'me too' - like some brain dead aoler.

I have 40+ machines which use XFS, and I have used it since the 1.0 was
released.  There are various servers, running a variety of services,
etc.  I think that the SGI team has done a fantastic job of supporting
2.4, and I have been using with no problems since 2.4.12.

I don't want to dis anyone either, but XFS is the filesystem that I use
because it is stable, and reliable, and IMHO mature.  I appreciate ext3,
Reiser, and especially JFS! However, XFS was ready first, and it was a
great disappointment not to see it in 2.4.  2.4 was truly a kernel of
pain in the beginning, and I repect the decision not to include it up
till now.  Not that it matters, but I will respect the decision of the
2.4 maintainers on this.  I do ask for 2.4, as a person who uses XFS on
all my personal, friends, mom's, and clients' systems.  Some of my
clients will not use it because it is not in the vanilla tree.  Please
reconsider on behalf of a wide body of users.

thanks,
  Joshua Schmidlkofer

