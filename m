Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbTIXD4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTIXD4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:56:23 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43684
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261355AbTIXD4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:56:20 -0400
Date: Wed, 24 Sep 2003 05:56:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@work.bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924035629.GR16314@velociraptor.random>
References: <20030924032837.GP16314@velociraptor.random> <Pine.LNX.4.44.0309232032510.27940-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309232032510.27940-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 08:38:35PM -0700, Linus Torvalds wrote:
> And that was NEVER the issue, even though you keep bringing it up. Again

that is _the_ issue from my part, the thing that isn't remotely going to
make me think to use bitkeeper. If there wasn't that clause in the
licence I would probably find acceptable to use it in the meantime.

But I guess I'd better go away as you ask since I feel like nobody
understands why I'm not using it despite I'm trying to explain it a few
times already.

> The issue is that you should not complain about other peoples choices. 

I'm not complaining about that, I was making a suggestion to Marcelo
outlighting what was possible to achieve if it was open (yeah, it's a
minor thing). Larry even said what I suggested was not an optimal fix
and I agree with that so I will try to fix it right. I think it was a
productive suggestion after all.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
