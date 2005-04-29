Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVD2Se7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVD2Se7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVD2Se7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:34:59 -0400
Received: from dialin-156-1.tor.primus.ca ([216.254.156.1]:33979 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262726AbVD2Sez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:34:55 -0400
Date: Fri, 29 Apr 2005 14:34:11 -0400
From: William Park <opengeometry@yahoo.ca>
To: "David N. Welton" <davidw@dedasys.com>
Cc: Daniel Drake <dsd@gentoo.org>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, helge.hafting@hist.no
Subject: Re: rootdelay
Message-ID: <20050429183411.GA1998@node1.opengeometry.net>
Mail-Followup-To: "David N. Welton" <davidw@dedasys.com>,
	Daniel Drake <dsd@gentoo.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
	helge.hafting@hist.no
References: <87wtrphuvj.fsf@dedasys.com> <424D929A.2030801@gentoo.org> <87pswjur3c.fsf@dedasys.com> <20050425144213.GA2293@node1.opengeometry.net> <87acnmee1s.fsf@dedasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87acnmee1s.fsf@dedasys.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 11:34:23PM +0200, David N. Welton wrote:
> > > > > http://dedasys.com/freesoftware/patches/blkdev_wakeup.patch

I patched it to 2.6.11, and it compiles okey.  On boot, it prints
    "Waiting for root device to wake us up."
then it waits for my USB key to register.  After USB partition info
prints to screen, above message is printed
    "Waiting for root device to wake us up."
again.  Then, it just hangs forever.

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because it works.
