Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVKQMMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVKQMMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 07:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVKQMMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 07:12:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:22425 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750767AbVKQMMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 07:12:33 -0500
Date: Thu, 17 Nov 2005 13:12:31 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Greg KH <gregkh@suse.de>
Cc: mtk-lkml@gmx.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20051117065636.GC20684@suse.de>
Subject: Re: [RFC] HOWTO do Linux kernel development
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <3210.1132229551@www25.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

> > Under 'Documentation', there is the text:
> > 
> >     When new features are added to the kernel, it is recommended 
> >     that new documentation files are also added which explain how 
> >     to use the feature.
> > 
> > Could you also add something like:
> > 
> >     When a new feature changes the interface that the kernel 
> >     exposes to userland, it is recommended that you send 
> >     information or a man-pages patch explaining the change 
> >     to the manual pages maintainer at mtk-manpages@gmx.net.
> 
> Do you want to start documenting the sysfs tree interface?  

There should be a sysfs(5) man page.  Unfortunately there is 
not one yet.  If someone wants to start one off...

> Do you have
> man pages for all of the kernel syscalls now?

All, no.  Most, yes.

> Anyway, I'll add it, as it is better to error on the side of caution
> here.

Thanks.

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  Grab the latest
tarball at ftp://ftp.win.tue.nl/pub/linux-local/manpages/
and grep the source files for 'FIXME'.
