Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269895AbUIDLPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269895AbUIDLPy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269882AbUIDLNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:13:05 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:25794 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269886AbUIDLMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:12:36 -0400
Date: Sat, 4 Sep 2004 12:12:31 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Whitwell <keith@tungstengraphics.com>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <20040904120352.B14037@infradead.org>
Message-ID: <Pine.LNX.4.58.0409041207060.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
 <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org>
 <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org>
 <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org>
 <4139995E.5030505@tungstengraphics.com> <20040904120352.B14037@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > OK, I've found www.kernel.org, and clicked on the 'latest stable kernel' link.
> >   I got a file called "patch-2.6.8.1.bz2".  I tried to install this but
> > nothing happened.  My i915 still doesn't work.  What do I do now?
>
> You could start getting a clue.
>

Which is the problem, Keith was acting as a user with no clue, and why
should a user who can't get his graphics card working worry about kernel
upgrades, along with X upgrades, the DRI has a workable snapshot process
now that allows users to use their DRI supported graphics card now, not in
6 months time when the X release happens, and the distro picks up the X
release, they run a script it builds a module against their kernel,
breaking this for a small decrease in memory usage in an uncommon use
case and as far as I can see no better maintainability (or worse) is a bit
of an ask... we aren't coming up with these problems just to annoy kernel
developers they are real world issues.. that the DRI team deal with not
the kernel team....

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

