Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSGEWYE>; Fri, 5 Jul 2002 18:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSGEWYE>; Fri, 5 Jul 2002 18:24:04 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:25216 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S317589AbSGEWYD>;
	Fri, 5 Jul 2002 18:24:03 -0400
Subject: Re: prevent breaking a chroot() jail?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ag51e7$rru$1@abraham.cs.berkeley.edu>
References: <1025877004.11004.59.camel@zaphod>
	<ag48ui$fb5$1@ncc1701.cistron.net> <1025879850.11004.75.camel@zaphod> 
	<ag51e7$rru$1@abraham.cs.berkeley.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 06 Jul 2002 00:26:30 +0200
Message-Id: <1025907990.848.2.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-05 at 23:00, David Wagner wrote:

> Chroot is a lot better than nothing, but it doesn't provide a
> secure jail, especially not for root.  However, the following
> tools are intended to provide a secure jail, and may be of interest
> to you: SubDomain (http://www.immunix.org/subdomain.html), Janus
> (http://www.cs.berkeley.edu/~daw/janus/), and BSD's jail() system call
> come to mind.  Also, may I point you to the Linux Security Modules project
> (http://lsm.immunix.org/)?  I think you may find it of interest.

I havn't seen vserver mentioned in this thread.

http://www.solucorp.qc.ca/miscprj/s_context.hc

It disables a lot of capabilities (configurable) and other stuff.
Worth taking a look at.

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.
