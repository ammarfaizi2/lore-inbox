Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbTIAAMv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTIAAMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:12:51 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:48592 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263100AbTIAAMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:12:50 -0400
Date: Sun, 31 Aug 2003 17:12:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901001239.GB18458@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk> <20030831230219.GD24409@dualathlon.random> <20030831230728.GA4918@work.bitmover.com> <20030831232224.GF24409@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831232224.GF24409@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 01:22:24AM +0200, Andrea Arcangeli wrote:
> on the long run, the way I recommend you to act, is to have a script
> that turns the traffic shaping on on demand before/after using voip

That's a cool idea but unfortunately we are using the 3com NBX stuff
which is based on Wind River and we don't have any way to know that a
voice conversation is going on.  I suppose we could build a way based
on snooping the network though.  Have to think about that.

By the way, I'd love to replace the 3com stuff with something based
on Linux.  I strongly suspect that the phones could do better than they
are doing and we're getting the short end of the stick by going with some
closed answer.  But all the open answers don't come close to offering
what 3com does.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
