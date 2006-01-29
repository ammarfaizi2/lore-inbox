Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWA2HKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWA2HKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWA2HKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:10:41 -0500
Received: from tachyon.quantumlinux.com ([64.113.1.99]:33979 "EHLO
	tachyon.quantumlinux.com") by vger.kernel.org with ESMTP
	id S1750794AbWA2HKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:10:41 -0500
Date: Sat, 28 Jan 2006 23:11:14 -0800 (PST)
From: Chuck Wolber <chuckw@quantumlinux.com>
X-X-Sender: chuckw@localhost.localdomain
To: Greg KH <gregkh@suse.de>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, jmforbes@linuxtx.org,
       linux-kernel@vger.kernel.org, stable@kernel.org, zwane@arm.linux.org.uk,
       tytso@mit.edu, davej@redhat.com, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 0/6] 2.6.14.7 -stable review
In-Reply-To: <20060129053458.GA9293@suse.de>
Message-ID: <Pine.LNX.4.63.0601282221400.7205@localhost.localdomain>
References: <20060128021749.GA10362@kroah.com> <Pine.LNX.4.63.0601282028210.7205@localhost.localdomain>
 <20060129044307.GA23553@linuxtx.org> <Pine.LNX.4.63.0601282048380.7205@localhost.localdomain>
 <20060128205701.5b84922e.rdunlap@xenotime.net> <20060129053458.GA9293@suse.de>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2006, Greg KH wrote:

> No, it's not a 6 month window, I released this because people sent us 
> patches that they said should go into the 2.6.14-stable tree.  And as 
> people complained so much on lkml that we were dropping the old kernels 
> too fast, I never thought that people would complain that we are 
> maintaining older stuff that people seem interested in...

Don't think of it as a complaint. I'm sorry if it came off that way. It's 
anyone's job if they want to maintain any kernel release as long as they 
see fit.

I guess it's how we want to define ourselves. Was I mistaken to think that 
the -stable team maintains -stable for the current patch release only? 


> And, as always, anyone is free to take on maintaining any of the 
> different kernel versions for as long as they wish.
> 
> Does that help?

Well, that's the way it's always been. We have a late model 2.5 kernel 
that we still maintain in a level C avionics device on Boeing jets. You'd 
be amazed at how stable a 2.5 kernel can be made ;)


> Man, people complain when you don't maintain older kernels, and they 
> complain when you do...

Nope, wasn't complaining. It was an attempt at a dialog to more clearly 
define our purpose (or perhaps my personal understanding of it) *AND* let 
other developers know what to expect of us. We can choose to take on as 
much or as little as we want. I personally am good with whatever everyone 
else is comfortable taking on. We should manage outside expectations 
though so you don't have to answer "why do you drop old kernels" questions 
on your own. 

Things have changed a lot with the 2.6 release series and -stable seems to 
me to be one of those growing pains that still isn't fully resolved. It's 
a blending between the traditional stable release maintainers and the more 
nimble release schedule these days. Can the -stable team fill the void, or 
do we limit our scope to certain patch releases?

..Chuck..


-- 
http://www.quantumlinux.com
 Quantum Linux Laboratories, LLC.
 ACCELERATING Business with Open Technology

 "The measure of the restoration lies in the extent to which we apply
  social values more noble than mere monetary profit." - FDR
