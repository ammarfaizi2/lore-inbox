Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131937AbRBAXqm>; Thu, 1 Feb 2001 18:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131671AbRBAXqd>; Thu, 1 Feb 2001 18:46:33 -0500
Received: from www.qz.se ([195.42.197.28]:20122 "EHLO qz.se")
	by vger.kernel.org with ESMTP id <S131937AbRBAXqX>;
	Thu, 1 Feb 2001 18:46:23 -0500
Date: Fri, 2 Feb 2001 00:46:21 +0100 (CET)
From: Magnus Erixzon <magnus@erixzon.se>
To: dmeyer@dmeyer.net
cc: linux-kernel@vger.kernel.org
Subject: Re: What does "NAT: dropping untracked packet" mean?
In-Reply-To: <20010201181952.A5803@jhereg.dmeyer.net>
Message-ID: <Pine.LNX.4.21.0102020037490.15699-100000@fried.penguinbrain.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is explained in the netfilter FAQ.
http://netfilter.kernelnotes.org/netfilter-faq-3.html#ss3.1

 / Magnus


On Thu, 1 Feb 2001 dmeyer@dmeyer.net wrote:

> I'm getting the occasional
> 
> Feb  1 13:17:08 yendi kernel: NAT: 0 dropping untracked packet
> c3ea4da0 1 146.188.249.73 -> 209.220.232.240
> 
> syslog message.  What exactly does it mean?  146.188.249.73 isn't my
> machine at all, and 209.220.232.240 is my firewall.  I assume I'm
> dropping someone's packets on the floor, but what can cause a packet
> to get dropped like that?
> 
> -- 
> Dave Meyer
> dmeyer@dmeyer.net





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
