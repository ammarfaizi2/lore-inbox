Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVADAdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVADAdP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVADA3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:29:23 -0500
Received: from thunk.org ([69.25.196.29]:63392 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262048AbVADA2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:28:17 -0500
Date: Mon, 3 Jan 2005 19:24:52 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@stusta.de>,
       Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104002452.GA8045@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@stusta.de>,
	Diego Calleja <diegocg@teleline.es>,
	Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com,
	aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
	linux-kernel@vger.kernel.org
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com> <20050103183621.GA2885@thunk.org> <20050103185927.C3442@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103185927.C3442@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 06:59:27PM +0000, Russell King wrote:
> On Mon, Jan 03, 2005 at 01:36:21PM -0500, Theodore Ts'o wrote:
> > This is the model that we used with the
> > 2.3.x series, where the time between releases was often quite short.
> > That worked fairly well, but we stopped doing it when the introduction
> > of BitKeeper eliminated the developer synch-up problem.  But perhaps
> > we've gone too far between 2.6.x releases, and should shorten the time
> > in order to force more testing.  
> 
> It is also the model we used until OLS this year - there was a 2.6
> release about once a month prior to OLS.  Post OLS, it's now once
> every three months or there abouts, which, IMO is far too long.

I was thinking more about every week or two (ok, two releases in a day
like we used to do in the 2.3 days was probably too freequent :-), but
sure, even going to a once-a-month release cycle would be better than
the current 3 months between 2.6.x releases.

						- Ted
