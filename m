Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285593AbRL3WcF>; Sun, 30 Dec 2001 17:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285634AbRL3Wbz>; Sun, 30 Dec 2001 17:31:55 -0500
Received: from svr3.applink.net ([206.50.88.3]:23822 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S285593AbRL3Wbh>;
	Sun, 30 Dec 2001 17:31:37 -0500
Message-Id: <200112302231.fBUMVTSr012088@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Date: Sun, 30 Dec 2001 16:27:40 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011227195037.GA229@znex> <200112302117.fBULHISr011887@svr3.applink.net> <3C2F8727.5D4AAE21@zip.com.au>
In-Reply-To: <3C2F8727.5D4AAE21@zip.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 December 2001 15:29, you wrote:
> Timothy Covell wrote:
> >         When X11 locks up, I can still kill it and my box lives.  When
> > framebuffers crash, their is no recovery save rebooting.  Back in 1995
> > I thought that linux VTs and X11 implemenation blew Solaris out of the
> > water, and now we want throw away our progress?  I'm still astounded
> > by the whole "oooh I can see  a penquin while I boot-up" thing?
> > Granted, frame buffers have usage in embedded systems, but do they
> > really have to be so deeply integrated??
>
> Well that's news to me....
>
> If you can send me a simple step-by-step means by which to
> reproduce this, I'll take a shot at fixing it.


Andrew,

	Well, I was making reference to Solaris where I have seen
lots of X11 crashes mean framebuffer crashes which means the console
is unusable.   I haven't played with it on Linux enough to know for sure that 
Linux doesn't suffer the same problems.  If that's true, then hats off to you
all for again showing how Solaris sucks.


-- 
timothy.covell@ashavan.org.
