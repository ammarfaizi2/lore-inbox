Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTJ3Qz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 11:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbTJ3QzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 11:55:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:778 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262655AbTJ3QzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 11:55:17 -0500
Date: Thu, 30 Oct 2003 11:44:47 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test9
In-Reply-To: <20031030092045.A18808@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1031030113206.6313A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, Russell King wrote:

> On Mon, Oct 27, 2003 at 11:26:44PM +0000, bill davidsen wrote:
> > If the idea is to tell people to read the post-Halowe'en doc and a year
> > of LKML, it is much the same as telling people to wait for a
> > distribution.
> 
> Isn't the purpose of the post-haloween doc to tell people what
> changed and what needed to be upgraded?  What about the
> linux/Documentation/Changes file?

Given that it is a year out of date and general in nature, it's still a
pretty useful docuement to someone who does a lot of fiddling anyway.
But what I think would be very useful would be a small (one screen?)
HTML doc with links to versions which are current today, one page each
for a few major distros covering tweaks to startup file and the like,
and a page of things which aren't mentioned in the post Halowe'en doc,
like the things that aren't available in modules anymore.

Anyway, since I found that even my notes were out of date, and I took
them as I moved machines from 2.5.4x forward to test9, I thought it
would be useful. I'll probably do something for my friends and clients,
but it will definitely be Redhat and Slackware only. I see no enthusiasm
for helping users instead of letting them thrash.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

