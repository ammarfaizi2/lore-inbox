Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUDJH4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 03:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUDJH4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 03:56:39 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:43187 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261815AbUDJH4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 03:56:38 -0400
Date: Sat, 10 Apr 2004 08:56:36 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [patch] Trying to get DRM up to date in 2.6
In-Reply-To: <20040409120106.69e78838.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404100847500.4138@skynet>
References: <Pine.LNX.4.58.0404090838000.30863@skynet> <20040409120106.69e78838.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> >  I've setup a temporary BK repo at http://freedesktop.org:1234/drm-2.6/
>
> Yes, that works.  Anything which you put into that bk tree will
> automagically appear in my test kernels.  When we're happy with it you can
> ask Linus to merge it into the top-level tree.
>

Okay I've pushed all the first set of changes from the DRM CVS tree into
the BK repo above. I'm going to move to a repo on bkbits rsn, will send an
updated URL when I do so ..

I think there is one major changeset outstanding that I'll get around to
in the next couple of days, the only other changes I can see between the
trees are compatibility changes for 2.4 which I don't really want to put
into the 2.6 tree unless totally necessary...

I'd say let it be checked out in Andrews tree for a while and then I'll
ask Andrew to push it all onto Linus...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

