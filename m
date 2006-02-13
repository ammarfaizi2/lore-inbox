Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWBMVjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWBMVjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWBMVjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:39:31 -0500
Received: from solarneutrino.net ([66.199.224.43]:55560 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1030198AbWBMVjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:39:31 -0500
Date: Mon, 13 Feb 2006 16:39:29 -0500
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org, ryan@tau.solarneutrino.net
Subject: Re: Random reboots
Message-ID: <20060213213929.GG16566@tau.solarneutrino.net>
References: <20060213210435.GC16566@tau.solarneutrino.net> <20060213211044.066CE5E401E@latitude.mynet.no-ip.org> <20060213212243.GE16566@tau.solarneutrino.net> <7c3341450602131332x2fcd7d8co@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c3341450602131332x2fcd7d8co@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 09:32:21PM +0000, Nick Warne wrote:
> > Nope, no spamassassin.  It doesn't seem to happen at any particular time
> > of day/week/month or in conjunction with any particular load.
> 
> What is your base system on these boxes?  I have had 3 'reboots' on 2
> boxes at work over the last year running RHEL 3, and there is nothing
> *at all* in logs, nor in the tests scripts RedHat guys got me to run
> (nor hardware issues) - it's as if someone just hit the power switch.

It runs Debian Sarge for AMD64.  I have lots of other machines, but only
this one gets the reboots.  None of the others have SCSI, and none are
dual-CPU with memory on both nodes, just to name two obvious things
different on this machine.

And my symptoms are the same - nothing in the logs, nothing sent to the
syslog server, nothing on the serial console.  Just like a power cut.

-ryan
