Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbTIAAZy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTIAAZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:25:54 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:2001 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S263123AbTIAAZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:25:51 -0400
Date: Sun, 31 Aug 2003 17:25:43 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901002543.GD18458@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jamie Lokier <jamie@shareable.org>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <20030831225639.GB16620@work.bitmover.com> <20030831231305.GE24409@dualathlon.random> <20030901001819.GC29239@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901001819.GC29239@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 01:18:19AM +0100, Jamie Lokier wrote:
>   Every 19 seconds on average, 24x7, a new HTTP connection.

Wrong.  Every 19 seconds is a new BK connection.  The HTTP connections are
at least an order of magnitude more frequent.  And increasing, more and 
more people are becoming aware that the source is there and you can 
point to it.

>   That's one connection every 1.9 seconds.

Ha.  Don't I wish.  Peak connection rates are a lot higher than that.  

> Trivial ;)  Or disable bkbits.net during Larry's working day. ;)

It's not my working day or the other people who work locally, all our
phones are on a 100Mbit switched net to the 3com before it goes out on
POTS.  It's the remote people.  And half our company is currently remote.
I could write a book on how well remote does and doesn't work.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
