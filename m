Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266114AbUHFRya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUHFRya (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUHFRwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:52:34 -0400
Received: from web14926.mail.yahoo.com ([216.136.225.84]:57713 "HELO
	web14926.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266561AbUHFRsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:48:08 -0400
Message-ID: <20040806174801.39537.qmail@web14926.mail.yahoo.com>
Date: Fri, 6 Aug 2004 10:48:01 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: DRM function pointer work..
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4113BEC5.6030909@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Keith Whitwell <keith@tungstengraphics.com> wrote:

> 
> > The key here is that distributions release new kernels at a rapid
> pace.
> > This is not X where we get a new release every five years. The
> standard
> > mechanism for upgrading device drivers in Linux is to add them to
> the
> > kernel and wait for a release.  
> 
> So, people have to reboot to install a new graphics driver?   How
> very 
> windows...

You only have to reboot if you built drm-core into the kernel. If you
don't want to reboot don't do that.


> 
> At least with windows you don't have to re-install the whole OS
> first...
> 
> Keith
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by OSTG. Have you noticed the changes
> on
> Linux.com, ITManagersJournal and NewsForge in the past few weeks?
> Now,
> one more big change to announce. We are now OSTG- Open Source
> Technology
> Group. Come see the changes on the new OSTG site. www.ostg.com
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
> 


=====
Jon Smirl
jonsmirl@yahoo.com


		
_______________________________
Do you Yahoo!?
Express yourself with Y! Messenger! Free. Download now. 
http://messenger.yahoo.com
