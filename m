Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285047AbRL3VSY>; Sun, 30 Dec 2001 16:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285059AbRL3VSO>; Sun, 30 Dec 2001 16:18:14 -0500
Received: from svr3.applink.net ([206.50.88.3]:65037 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S285047AbRL3VSK>;
	Sun, 30 Dec 2001 16:18:10 -0500
Message-Id: <200112302117.fBULHISr011887@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Date: Sun, 30 Dec 2001 15:13:29 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011227195037.GA229@znex> <3C2D0D13.CB1C5683@zip.com.au> <3C2ED18D.FA550F1A@zip.com.au>
In-Reply-To: <3C2ED18D.FA550F1A@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 December 2001 02:34, Andrew Morton wrote:
> Andrew Morton wrote:
> > However I don't see why _any_ architecture wants framebuffer contents
> > to be included in core files.  It sounds risky.
> >

[snip]


	When X11 locks up, I can still kill it and my box lives.  When
framebuffers crash, their is no recovery save rebooting.  Back in 1995
I thought that linux VTs and X11 implemenation blew Solaris out of the
water, and now we want throw away our progress?  I'm still astounded
by the whole "oooh I can see  a penquin while I boot-up" thing?
Granted, frame buffers have usage in embedded systems, but do they
really have to be so deeply integrated??

-- 
timothy.covell@ashavan.org.
