Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTIAQYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTIAQYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:24:33 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:35051 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263012AbTIAQY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:24:28 -0400
Date: Mon, 1 Sep 2003 09:24:19 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901162419.GE1327@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <1062370358.12058.8.camel@dhcp23.swansea.linux.org.uk> <20030831230219.GD24409@dualathlon.random> <20030831230728.GA4918@work.bitmover.com> <20030831232224.GF24409@dualathlon.random> <1062416635.13372.17.camel@dhcp23.swansea.linux.org.uk> <20030901161316.GH11503@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901161316.GH11503@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 06:13:16PM +0200, Andrea Arcangeli wrote:
> The only object of my posts was to try to correct the misinformation
> that was spreading from Larry's posts that implied you had to buy a
> speparate connection to shape the bitkeeper connections doing clones of
> the tree. That's what I and everybody else understood. Now apparently he
> was wrong and the hurting factor aren't the bitkeeper clients cloning
> the tree but the webserver. So I'm glad to have reached my object.

I don't know what axe you are trying to grind but that's nonsense.  Yes,
I said when you start doing a clone the phones don't work but I never 
said "the only problem we have is that an out going clone causes problems".
That's clearly not true, there are incoming clones, pushes, outgoing pulls,
all sorts of HTTP traffic, etc.  

The problem is that you heard clone and you assumed that clone was the
ONLY source of traffic.  That's your problem, not mine, so don't go 
accusing me of spreading misinformation because you weren't thinking
or listening, please.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
