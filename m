Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUH2KxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUH2KxP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 06:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267623AbUH2KxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 06:53:15 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:31246 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S267618AbUH2KxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 06:53:05 -0400
Date: Sun, 29 Aug 2004 12:53:04 +0200 (CEST)
From: Robert Milkowski <milek@rudy.mif.pg.gda.pl>
To: "David S. Miller" <davem@davemloft.net>
cc: Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       alan@lxorguk.ukuu.org.uk, usenet-20040502@usenet.frodoid.org,
       miles.lane@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <20040828223018.53ec62e2.davem@davemloft.net>
Message-ID: <Pine.LNX.4.60L.0408291231170.15457@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
 <87hdqyogp4.fsf@killer.ninja.frodoid.org> <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
 <1093174557.24319.55.camel@localhost.localdomain>
 <Pine.LNX.4.60L.0408232107270.13955@rudy.mif.pg.gda.pl>
 <1093354658.2810.31.camel@localhost.localdomain>
 <Pine.LNX.4.60L.0408290154030.15099@rudy.mif.pg.gda.pl>
 <20040828223018.53ec62e2.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-384866184-1093776784=:15457"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-384866184-1093776784=:15457
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 28 Aug 2004, David S. Miller wrote:

> On Sun, 29 Aug 2004 02:14:03 +0200 (CEST)
> Tomasz K=B3oczko <kloczek@rudy.mif.pg.gda.pl> wrote:
>
>> If fact Solaris works quite well on usual desktop size computer.
>
> Check out the Solaris driver selection on x86 these days,
> it still stinks.  It is unlikely they'll ever have the coverage
> Linux does any time soon.

You are right with that. However it's getting better.
On the other hand Solaris works on a really wide spectrum of x86 servers=20
(Dell, HP, IBM). I've installed it on x86 servers from 1-way to 8-way=20
Compaqs. I've installed it on several desktop systems too.
But you are right - Linux has more drivers on x86 for some 'exotic'=20
hardware and home use. And has much more drivers for PCI RAID cards.


> Frankly, if the only specific technical feature Sun has to brag
> about in Solaris 10 is DTrace, that's pretty sad.  Even more so,
> most of the bugs I see being fixed in Solaris kernel patches
> are performance regressions against Linux.  This, given how things
> were 6 or 7 years ago and the things the Solaris folks used to
> flame us for, I find particularly amusing.

1. Why do you think that DTrace is the onle 'cool' feature in Solaris 10?
    Please stop FUD.

    Frankly, if the only specific technical feature Linux has to brag about
    in Linux 2.6 is KProbes, that's pretty sad.

    :P


2. "most of the bugs I see being fixed in Solaris kernel patches"

     1. there are no patches to Solaris 10 kernel so far, so you can't
        see them

     2. you are probably talking about some patches for Solaris 9 kernel
        coming from project ATLAS (performance improvements on x86 - to be
        as fast or faster then other OSes on the same hardware)

     3. and definitely you overstated saying these are most of the patches
        in fact I would be suprised if there are more then 10-20 such
        patches (and hundreds others). Maybe you see this 'coz you are
        looking for word 'Linux' in patches? :)))


3. "Solaris folks used to flame us for,"

     You know - there're trolls in every community.


And this thread was about DTrace and Linux tracing technologies (and not=20
trolls, PDAs, other features)... and I know, Linux can run on PDAs.
Ok, so when it comes to profiling and debugging:

 =091. Solaris has DTrace, ptools ant others
 =092. Linux runs on PDAs

:)))))))

ps. sorry for that... on the other hand a little bit of humour is ok :)


--=20
 =09=09=09=09=09=09Robert Milkowski
 =09=09=09=09=09=09milek@rudy.mif.pg.gda.pl

--8323328-384866184-1093776784=:15457--
