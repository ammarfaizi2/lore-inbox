Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269907AbUIDLU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269907AbUIDLU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269901AbUIDLQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:16:27 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:9222 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269883AbUIDLOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:14:03 -0400
Date: Sat, 4 Sep 2004 12:13:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904121355.E14123@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904120352.B14037@infradead.org> <Pine.LNX.4.58.0409041207060.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409041207060.25475@skynet>; from airlied@linux.ie on Sat, Sep 04, 2004 at 12:12:31PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 12:12:31PM +0100, Dave Airlie wrote:
> > > OK, I've found www.kernel.org, and clicked on the 'latest stable kernel' link.
> > >   I got a file called "patch-2.6.8.1.bz2".  I tried to install this but
> > > nothing happened.  My i915 still doesn't work.  What do I do now?
> >
> > You could start getting a clue.
> >
> 
> Which is the problem, Keith was acting as a user with no clue, and why
> should a user who can't get his graphics card working worry about kernel
> upgrades, along with X upgrades, the DRI has a workable snapshot process
> now that allows users to use their DRI supported graphics card now, not in

A user without a clue should better be using a supported distribution.
If he used Fedora Core2 instead of the totally outdated and unsupported
RH9 he'd already have a kernel with i915 support on his disk.


