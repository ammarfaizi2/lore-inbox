Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318787AbSHRBeP>; Sat, 17 Aug 2002 21:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318789AbSHRBeP>; Sat, 17 Aug 2002 21:34:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34056 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318787AbSHRBeO>; Sat, 17 Aug 2002 21:34:14 -0400
Date: Sat, 17 Aug 2002 18:41:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Anton Altaparmakov <aia21@cantab.net>, <alan@lxorguk.ukuu.org>,
       Andre Hedrick <andre@linux-ide.org>, <axboe@suse.de>, <vojtech@suse.cz>,
       <bkz@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE?
In-Reply-To: <1029614199.4634.32.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208171839420.1310-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Aug 2002, Alan Cox wrote:
> 
> If we can do it that way I'll do the job. If Linus applies random IDE
> "cleanup" patches to his 2.5 tree that don't pass through Jens and me
> then I'll just stop listening to 2.5 stuff.

That may work for the low-level driver stuff, but not for things like the
partitioning fixes. Especially as some of that is different in 2.5.x 
relative to 2.4.x.

In other words, I'll clearly apply anything that comes from Al, at the 
very least.

		Linus

