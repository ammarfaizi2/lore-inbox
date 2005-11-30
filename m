Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVK3Fbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVK3Fbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbVK3Fbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:31:55 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:36622 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751055AbVK3Fby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:31:54 -0500
Date: Wed, 30 Nov 2005 06:31:08 +0100
From: Willy Tarreau <willy@w.ods.org>
To: jdow <jdow@earthlink.net>
Cc: Nick Warne <nick@linicks.net>, Wakko Warner <wakko@animx.eu.org>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] 1500 days uptime.
Message-ID: <20051130053108.GU11266@alpha.home.local>
References: <200511242147.45248.nick@linicks.net> <438B89EE.9080707@tmr.com> <20051129003159.GA4643@animx.eu.org> <200511292226.49873.nick@linicks.net> <036c01c5f539$c54bd730$1225a8c0@kittycat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <036c01c5f539$c54bd730$1225a8c0@kittycat>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 03:08:10PM -0800, jdow wrote:
> From: "Nick Warne" <nick@linicks.net>
(...)
> >No, I wasn't even thinking that - just reporting what a wonderful job it 
> >all is - and yes, power supply here in Pompey UK is good (but we do pay 
> >thru' the nose for everything in the UK).  The last time I _did_ reboot 
> >that machine was when my kettle lead shorted out and blew the fuses to 
> >my flats 240v supply ring main.
> >
> >According to the Linux counter site, there are more higher (my machine 
> >is 3rd in the list):
> >
> >http://counter.li.org/reports/uptimestats.php
> 
> There is an interesting point here that is worth noting. I don't think I
> would BEGIN to try this with a 2.6 based kernel. And I am not sure it is
> doable yet with a 2.4 kernel if the machine is to be exposed to the wild.

it may depend on what you do with it. I reached 1000 days with a
2.4.19pre5 plus a lot of patches a few years ago. However, it would
have been dangerous to leave this machine exposed because there were
so many local root exploits that the smallest vulnerability in any
installed service would have cause a disaster. But I also have some
machines running 2.4.22+some patches which have not been rebooted
since kernel upgrade, and which are used as front firewalls on a
big fat internet pipe, and they are still up and running normally.
So I can say that 2.4 was stable enough 2 years ago, and is even
more right now. Judging from the many people reporting years of
uptime (and from local experience), it seems that 2.4 reached such
a stability around 2.4.18.

> {o.o}    Joanne Dow

Regards,
Willy

