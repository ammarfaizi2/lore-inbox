Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVC1BjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVC1BjL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 20:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVC1BjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 20:39:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29202 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261650AbVC1BjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 20:39:04 -0500
Date: Mon, 28 Mar 2005 03:39:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <greg@kroah.com>, Lee Revell <rlrevell@joe-job.com>,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050328013902.GK4285@stusta.de>
References: <20050326182828.GA8540@kroah.com> <1111869274.32641.0.camel@mindpipe> <20050327004801.GA610@kroah.com> <1111885480.1312.9.camel@mindpipe> <20050327032059.GA31389@kroah.com> <1111894220.1312.29.camel@mindpipe> <20050327181056.GA14502@kroah.com> <1111948631.27594.14.camel@localhost.localdomain> <20050327220139.GI4285@stusta.de> <1111967692.27381.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111967692.27381.8.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 06:54:52PM -0500, Steven Rostedt wrote:
> On Mon, 2005-03-28 at 00:01 +0200, Adrian Bunk wrote:
> > 
> > How do you define "proven in court"?
> > 
> > Decided by an US judge based on US laws?
> > Decided by a German judge based on German laws?
> > Decided by a Chinese judge based on Chinese laws?
> > ...
> > 
> 
> OK, I was talking about US courts since that case was done in the US.
> But this is all what I remember about reading some 10 years ago. So I
> could be all wrong about what happened. I don't have any references and
> I'm too busy now to look them up. So I may be just speaking out of my
> ass. :-)
> 
> > If you distribute software you can be sued in every country you 
> > distribute it.
> > 
> > E.g. Harald Welte is currently quite successful with legal actions in 
> > Germany against companies that distribute Linux-based routers in Germany 
> > without offering the source of the GPL'ed software they use.
> 
> Your talking about something completely different.  Yes, it is quite
> explicit if you modify the source, and distribute it in binary only
> form.  I'm talking about writing a separate module that links with the
> GPL code dynamically.  So that the code is compiled different from the
> GPL code. So the only common part is the API. Now is this a derived
> work? 
>...

My point was a bit different:

Harald's action was meant as an example, that such things can be brought 
to court in virtually every country in the world.

And a court decision in e.g. the USA might not have any influence on a 
court decision in e.g. Germany.

Some people seem to think that it was enough if something was OK 
according to US law - but that's simply wrong.

> -- Steve

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

