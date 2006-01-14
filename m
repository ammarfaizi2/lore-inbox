Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945969AbWANBlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945969AbWANBlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945972AbWANBlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:41:23 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:27264 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1945969AbWANBlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:41:22 -0500
Date: Fri, 13 Jan 2006 17:51:24 -0800
From: thockin@hockin.org
To: Andreas Steinmetz <ast@domdv.de>
Cc: David Lang <dlang@digitalinsight.com>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
Message-ID: <20060114015124.GA11611@hockin.org>
References: <1137190698.2536.65.camel@localhost.localdomain> <Pine.LNX.4.62.0601131448150.9821@qynat.qvtvafvgr.pbz> <43C848C7.1070701@domdv.de> <Pine.LNX.4.62.0601131701590.9821@qynat.qvtvafvgr.pbz> <43C85213.40808@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C85213.40808@domdv.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 02:21:23AM +0100, Andreas Steinmetz wrote:
> > neither of these are fixes, but by understanding the different costs
> > people can choose the work around they want to use while waiting for a
> > better fix.
> 
> The problem being that some of us use their laptops for audio work too.
> And then high battery usage, noisy fans or lack of high res timers will
> be really bad.
> 
> Simple example:
> I do final mastering work using my laptop and Ardour/Jack/JAMin out of
> house in a place with a good stage audio system (Mackie mixer, 2KW
> Dynacord Amp/Syrincs S3) and a sufficient listening space to get a
> proper bass mix. I run on battery in this case to avoid any kind of
> audio interference (ground loops, etc). Now thinking of a dual core
> laptop...

Fixes are coming, just need to sort out the fidlly bits.
