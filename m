Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbUB0Jpt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 04:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUB0Jpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 04:45:49 -0500
Received: from zadnik.org ([194.12.244.90]:217 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S261761AbUB0Jpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 04:45:46 -0500
Date: Fri, 27 Feb 2004 11:45:26 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: Rik van Riel <riel@redhat.com>
Cc: Jesse Pollard <jesse@cats-chateau.net>,
       Timothy Miller <miller@techsource.com>,
       Christer Weinigel <christer@weinigel.se>,
       Nikita Danilov <Nikita@Namesys.COM>, <root@chaos.analogic.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <Pine.LNX.4.44.0402261211510.5629-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0402271138510.26240-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Rik van Riel wrote:

> On Thu, 26 Feb 2004, Jesse Pollard wrote:
>
> > Until you add IPSEC...
> >
> > Unless the TOE has the same security support (encrypt some packets, not
> > others, require verification from some networks, not others,...), and
> > flexibility that the Linux network stack has, and ...
>
> Exactly.  I just don't see TOE as a viable option for
> networking, so I'm not too worried about not supporting
> it.

It depends. Some of these integrated gadgets aren't very successful;
others, however, are. Compare true modems to winmodems, or modern
videocards with built-in rendering etc to bare ones. Also, on embedded
systems with very tight memory and speed requirements, a TOE card may be a
bad, but the only available solution.

So, IMO, a proposed kernel model must have the means to support similar
devices. Some will be bad, but some may be good.


