Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWEONty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWEONty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWEONty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:49:54 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:2506 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932398AbWEONtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:49:53 -0400
Date: Mon, 15 May 2006 09:49:19 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Nutan C." <nutanc@esntechnologies.co.in>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       Fawad Lateef <fawadlateef@gmail.com>, jjoy@novell.com,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, gauravd.chd@gmail.com,
       bulb@ucw.cz, greg@kroah.com, Shakthi Kannan <cyborg4k@yahoo.com>,
       "Srinivas G." <srinivasg@esntechnologies.co.in>
Subject: RE: GPL and NON GPL version modules
In-Reply-To: <Pine.LNX.4.58.0605150937190.16618@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605150946340.16618@gandalf.stny.rr.com>
References: <AF63F67E8D577C4390B25443CBE3B9F7092952@esnmail.esntechnologies.co.in>
 <Pine.LNX.4.58.0605150937190.16618@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 May 2006, Steven Rostedt wrote:

>
> On Mon, 15 May 2006, Nutan C. wrote:
>
> > Ok, so now, I have a new doubt :-) Forgive me, if I am asking a lot, but
> > I really don't want to move ahead with the development, until and unless
> > I am sure I am not violating GPL. So, please bear with me. Here's the
> > question:
> >
> > 1. I developed a code which interfaces well with a proprietary OS. Now,
> > somebody else feels to use the same module in his Linux Kernel. So, he
> > comes up with a patch, which interfaces and talks to my module with my
> > interfaces and then makes a release with the patch. And, I would have no
> > idea of my module being really compatible/used in Linux Kernel. One fine
> > day, I would get a mail saying that I need to make my code open source.
> > What would be my reply?
> >
>
> Big fat answer is No!  You are not distributing GPL code.  Just because
> someone made GPL code that interacts with your module, doesn't make you
> responsible for it. (OK now for a IANAL disclaimer)  I'm not a lawyer, but
> I would bet my career on this one (at least in the US).
>
> You cant be held responsible for someone else's actions.
>
> So your reply is simple:
>
> I'm sorry, but I don't distribute GPL code, please see your distributor.


One more note.  The person that distributed the GPL code with your module
may be the one in the "grey area". But then again, how can your module be
a derived work if the author didn't even intend on having it work with
Linux?

-- Steve

