Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318356AbSIPAuW>; Sun, 15 Sep 2002 20:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSIPAuV>; Sun, 15 Sep 2002 20:50:21 -0400
Received: from bitmover.com ([192.132.92.2]:55215 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S318356AbSIPAuV>;
	Sun, 15 Sep 2002 20:50:21 -0400
Date: Sun, 15 Sep 2002 17:55:13 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Daniel Phillips <phillips@arcor.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020915175513.A22056@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Daniel Phillips <phillips@arcor.de>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <E17qRfU-0001qz-00@starship> <20020915020739.A22101@devserv.devel.redhat.com> <E17qalv-0000B6-00@starship> <20020915142304.A21363@devserv.devel.redhat.com> <3D84D29D.5090604@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D84D29D.5090604@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Sep 15, 2002 at 02:34:05PM -0400
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 02:34:05PM -0400, Jeff Garzik wrote:
> Pete Zaitcev wrote:
> > This has nothing to do with a debugger, this is a different topic.
> > You actually want a crash dump analyzis tool, and so do I.
> > So, let's discuss that. I happen to get e-mails with oops in USB
> > callbacks pretty often, and they are always useless. It would be
> > possible to track them if off-stack memory was saved, perhaps.
> > However, to expect users to use debugger to collect this off-stack
> > information is a delusion.
> 
> http://lkcd.sourceforge.net/
> 
> Linux crash dumps, and includes an analysis tool...

I used to work with the guy behind this, at SGI.  He was one of three
people in all of SGI that I wanted to hire after I left.  I haven't played
with this yet but I'll bet you 100:1 odds that you'll like it if Matt
did it.  He rocked at SGI.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
