Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTKJTgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTKJTfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:35:15 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27667 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264080AbTKJTeP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:34:15 -0500
Date: Mon, 10 Nov 2003 14:22:33 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Ragnar Hojland Espinosa <ragnar@linalco.com>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311080950520.2787-100000@home.osdl.org>
Message-ID: <Pine.LNX.3.96.1031110141932.6278H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Nov 2003, Linus Torvalds wrote:


> Quite frankly, if it's literally been broken since 2.3.x, I think the best 
> thing to do would be to remove the driver entirely.

For no-longer-current hardware that would probably not be such a bad
thing.
> 
> Yeah, there's probably a fair number of those old CD-ROM drivers that 
> nobody uses with modern kernels (ie they might be used on some router that 
> hasn't been touched in forever, still running 2.2.x on a 8MB 386SX-16).

Well, I ran DNS on such a beast with 1.2.13 (from memory) until Y2k scared
me into updating the whole setup. But iptables is so much better than
ipchains that I hope there are fewer people using 2.2 for routers!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

