Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267589AbUHPMYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267589AbUHPMYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUHPMYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:24:19 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:4299 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267576AbUHPMW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:22:59 -0400
Date: Mon, 16 Aug 2004 13:22:57 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjanv@redhat.com, DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DRM and 2.4 ...
In-Reply-To: <1092654860.20517.22.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408161317250.32584@skynet>
References: <Pine.LNX.4.58.0408160652350.9944@skynet> 
 <1092640312.2791.6.camel@laptop.fenrus.com> <1092654860.20517.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > ways. 2.4 is the release for doing strict maintenance; people who want
> > to run newer X will generally run 2.6 kernels as well anyway.
>
> Then 2.4 users can't use the new Xorg release fully. That would be
> rather out of keeping with X policy.

Nope never said that, they won't be able to use the one after this one ;-)

They can use as much of the release as they can currently, if they want
new 3D driver features they'll need to upgrade.. (to be honest there isn't
much extra in the DRM from Xorg 6.7 to Xorg 6.8).. and I'd like to get the
DRM be a kernel thing rather than a X thing all this spread-out
development doesn't seem to be helping anyone...

And if we do get around to this great super unified graphics driver that
also ends world hunger I ain't backporting it to 2.4 :-)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

