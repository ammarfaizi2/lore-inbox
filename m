Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTIVSy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTIVSy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:54:57 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([67.60.40.239]:660
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S261603AbTIVSyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:54:55 -0400
Date: Mon, 22 Sep 2003 14:54:52 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: adi007@germanynet.de
cc: linux-kernel@vger.kernel.org, <vishwas@india.hp.com>
Subject: Re: Was [BUG?][2.4.xx] - SB Driver (SBAWE32) - Explosion sound on
 init 
Message-ID: <Pine.LNX.4.44.0309221453100.23307-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As of late 2.5 and 2.6 this is no longer occuring for me. I believe we now
are flushing the card's mixer settings and such.

Shawn S.

-------------
From: Adrian G. (adi007@germanynet.de)
Subject: Re: [BUG?][2.4.xx] - SB Driver (SBAWE32) - Explosion sound on
init


View this article only
Newsgroups: linux.kernel
Date: 2003-02-11 07:14:11 PST


Hi Shawn,

Shawn Starr <spstarr@sh0n.net> wrote in message
news:<20030210041006$34c1@gated-at.bofh.it>...
> Odd, When I boot up with 2.4.20 and the sound driver is about to init I
hear a
> explosion sound from the speakers each time I power off and on the
machine.
>
> Is this a initialization bug in resetting the card on boot?
>
> Any ideas?
>
> Shawn.
>
> -

I have the same experience with my AWE64 (CT4500), I haven't been
able to locallise the problem yet, but now we know that there must
be something with the sb-driver.

adrian


