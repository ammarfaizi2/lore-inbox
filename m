Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTIAA1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbTIAA1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:27:49 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:36323
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263150AbTIAA1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:27:48 -0400
Date: Mon, 1 Sep 2003 02:28:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030901002815.GB11503@dualathlon.random>
References: <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random> <20030831225639.GB16620@work.bitmover.com> <20030831231305.GE24409@dualathlon.random> <20030901001819.GC29239@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901001819.GC29239@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 01:18:19AM +0100, Jamie Lokier wrote:
> So, near-total annihilation of bkbits.net when Larry or any of his
> team are on the phone should work.  You can either integrate the phone

this is *exactly* my point.

Of course near-total annihilation of bkbits.net may not be acceptable to
the community, but still it should work as a proof of concept.

Depending on the connect/sec of the http server (not bkbits, for the
largest part of the conversation I couldn't know about the http server,
Larry only mentioned the bkbits.net clone until recently), the
"reservation" margin will have to change: the less connect/sec the
smaller margin Larry will need to reserve, the more connect/sec the
bigger marging will be necessary.

Andrea
