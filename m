Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWBBUke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWBBUke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWBBUke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:40:34 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:10638 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932227AbWBBUkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:40:33 -0500
Date: Thu, 2 Feb 2006 20:39:20 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [git pull] drm patches for 2.6.16
In-Reply-To: <Pine.LNX.4.64.0602020749510.21884@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0602022037360.3377@skynet>
References: <Pine.LNX.4.58.0602020913460.19173@skynet>
 <Pine.LNX.4.64.0602020749510.21884@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > commit 30e2fb188194908e48d3f27a53ccea6740eb1e98
> > Author: Dave Airlie <airlied@starflyer.(none)>
> > Date:   Thu Feb 2 19:37:46 2006 +1100
> >
> >     sem2mutex: drivers/char/drm/
> >
> >     From: Arjan van de Ven <arjan@infradead.org>
>
> A lot of your commits have this structure.
>
> What do you use to apply these emails? It _looks_ like the emails are
> well-behaved ("From:" at the top), yet your Author: information is wrong
> and whatever script you used to do it missed it.
>
> 		Linus
>

I mostly apply the patches + any cleanups (most of the patches I get from
DRM CVS needs whitespace cleanups - damn X hackers) so I usually just
write the commit message by hand from the mail when I check the stuff in,

I don't know of any way when doing hand commits to easily change the
author without messing with environment variables...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

