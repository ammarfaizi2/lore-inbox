Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVC0WBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVC0WBn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVC0WBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:01:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4881 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261599AbVC0WBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:01:40 -0500
Date: Mon, 28 Mar 2005 00:01:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <greg@kroah.com>, Lee Revell <rlrevell@joe-job.com>,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050327220139.GI4285@stusta.de>
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk> <20050326182828.GA8540@kroah.com> <1111869274.32641.0.camel@mindpipe> <20050327004801.GA610@kroah.com> <1111885480.1312.9.camel@mindpipe> <20050327032059.GA31389@kroah.com> <1111894220.1312.29.camel@mindpipe> <20050327181056.GA14502@kroah.com> <1111948631.27594.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111948631.27594.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 01:37:11PM -0500, Steven Rostedt wrote:
>...
> Wasn't this long ago proven in court that the license of headers can't
> control the code that calls them.  IIRC, it was with X Motif and making
> free libraries for that. So, actually it was for a free solution for a
> non free one (the other way around).  I believe the case sided on the
> free use. But then again the free code may have had to write their own
> headers and only the API was free. So if you want to compile against the
> kernel, you may need to work on rewriting the headers from scratch. Ah,
> but what do I know?
>...

How do you define "proven in court"?

Decided by an US judge based on US laws?
Decided by a German judge based on German laws?
Decided by a Chinese judge based on Chinese laws?
...

If you distribute software you can be sued in every country you 
distribute it.

E.g. Harald Welte is currently quite successful with legal actions in 
Germany against companies that distribute Linux-based routers in Germany 
without offering the source of the GPL'ed software they use.

> -- Steve

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

