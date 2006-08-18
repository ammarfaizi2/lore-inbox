Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWHRTJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWHRTJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWHRTJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:09:53 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61370 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932400AbWHRTJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:09:52 -0400
Subject: Re: R: How to avoid serial port buffer overruns?
From: Lee Revell <rlrevell@joe-job.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <20060818190106.GG21101@flint.arm.linux.org.uk>
References: <NBBBIHMOBLOHKCGIMJMDGEIMFNAA.g.tomassoni@libero.it>
	 <1155920400.24907.63.camel@mindpipe>
	 <20060818170450.GC21101@flint.arm.linux.org.uk>
	 <1155922240.2924.5.camel@mindpipe>
	 <20060818183430.GD21101@flint.arm.linux.org.uk>
	 <1155927174.2924.28.camel@mindpipe>
	 <20060818190106.GG21101@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 15:09:50 -0400
Message-Id: <1155928190.2924.36.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 20:01 +0100, Russell King wrote:
> What problem are we talking about here again?  Sorry, I've completely
> lost track and this particular thread of 26 messages is soo convoluted
> and too much to re-read.
> 

I thought I might have been seeing the same problem as the OP, but I've
found it's a separate issue.  I'll start a new thread.

The original poster in this thread was just wondering how to reduce the
number of serial overruns at baud rates over 19200.

> Since you only appear to be the messenger, wouldn't it be far better
> to get the person with the problem to report and respond rather than
> sitting in the middle?

Sorry, it took me a while but I have access to the machine with the
problem now.

Lee

