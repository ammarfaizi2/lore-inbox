Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTJWBR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 21:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTJWBR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 21:17:28 -0400
Received: from hockin.org ([66.35.79.110]:30727 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261500AbTJWBRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 21:17:23 -0400
Date: Wed, 22 Oct 2003 18:06:57 -0700
From: Tim Hockin <thockin@hockin.org>
To: "Joseph D. Wagner" <theman@josephdwagner.info>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Message-ID: <20031023010657.GA2476@hockin.org>
References: <200310221855.15925.theman@josephdwagner.info> <20031023001547.GA18395@redhat.com> <200310221947.45996.theman@josephdwagner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310221947.45996.theman@josephdwagner.info>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 07:47:45PM +0600, Joseph D. Wagner wrote:
> > Last time I looked these made absolutely no difference to performance
> > due to the only differences being on FP code.
> 
> So what?  Some other kernel developer -- like a module/driver developer, a 
> real-time systems developer, a simulations developer, or just some guy 
> messing around (read: student) -- might really want or even need those 
> specific optimizations.

Justify how someone NEEDs something that does nothing?

> Isn't this whole free-as-in-freedom software thing about giving developers 
> and end-users options they wouldn't otherwise have under closed source 
> alternatives?  In that spirit, shouldn't developers have the option of 
> optimizing for those specific processors?

They do - it's easy enough to hack in.  Go for it.  

> And don't give me this crap that being open source means I can do it myself.  

Ahh, grumpy AND lazy.  Listen.  By your your logic we should support EVERY
FEATURE that ANY PERSON can imagine.  Everyone should have choice, right?

Wrong.  Freedom means you are free to do whatever you want.  Change it, use
it, add whatever features you think are right.  It doesn't burden ME to do
your work for you, and it doesn't give you a right to come in with your guns
blasting because we didn't put something in that YOU wanted.  It's still OUR
project.  WE the people who help.  I'm not Linus or Alan or the long list of
headliners, but I help, too.  And I don't like your fucking attitude.

> instead of chosing between an operating system they like and an operating 
> system they hate, people end up choosing between an operating system they 
> hate and an operating system they really hate.

Because some compiler 'optimizations' that might yield a couple percent
speedup on in-kernel code (a small chunk of the code that runs on a
system, I might add) will SURELY turn a user from like to hate.

> This is one of the reasons why I've never contributed to any open source 
> project: the my-way-or-the-highway attitude of the existing developer base 
> makes attempts for newbies to get inside an invintation for unnecessary 
> pain.

How high and mighty you are.  If you don't like the way I or WE or THEY run
OUR projects, feel free to do your own.  Heck, start with our source base,
and fork it off.  Run your own damn project and see how well you do.

After this, I don't WANT you on any of my projects.  BUZZ OFF.

> Unless there's some hidden section of makefile code I don't know about, you 
> can count the number of lines that would have to be changed to meet my 
> request on the fingers of one of your hands.  If you don't make the change, 
> I will consider it conclusive proof that the whole free-as-in-freedom is 
> really just free-as-in-beer.

Please fuck off,  Joseph D. Wagner.  We should take all that code out just
so we could watch you leave.  You can't make ultimatums with people who
don't care.

Why don't you go spend your time crusading for something that might matter.
How about  you go get all the distros to compile every package with every
arch specific optimization.  You're more likely to see a benefit, and you're
probably more likely to succeed at that than you are at making us care about
your sad little tyrade.

Welcome to my killfile.

