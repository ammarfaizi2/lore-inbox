Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267605AbUH2KpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267605AbUH2KpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 06:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUH2KpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 06:45:25 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:18958 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S267605AbUH2KpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 06:45:16 -0400
Date: Sun, 29 Aug 2004 12:45:12 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: "David S. Miller" <davem@davemloft.net>
cc: alan@lxorguk.ukuu.org.uk, milek@rudy.mif.pg.gda.pl,
       usenet-20040502@usenet.frodoid.org, miles.lane@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <20040828223018.53ec62e2.davem@davemloft.net>
Message-ID: <Pine.LNX.4.60L.0408291154300.15099@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
 <87hdqyogp4.fsf@killer.ninja.frodoid.org> <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
 <1093174557.24319.55.camel@localhost.localdomain>
 <Pine.LNX.4.60L.0408232107270.13955@rudy.mif.pg.gda.pl>
 <1093354658.2810.31.camel@localhost.localdomain>
 <Pine.LNX.4.60L.0408290154030.15099@rudy.mif.pg.gda.pl>
 <20040828223018.53ec62e2.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1093731136-1093776312=:15099"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1093731136-1093776312=:15099
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT


<disclaimer>
I'm not try to advocate on Solaris or on Linux. I'm interested to 
incorporate DTrace like solution in Liunux.
</disclaimer>

On Sat, 28 Aug 2004, David S. Miller wrote:

> On Sun, 29 Aug 2004 02:14:03 +0200 (CEST)
> Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl> wrote:
>
>> If fact Solaris works quite well on usual desktop size computer.
>
> Check out the Solaris driver selection on x86 these days,
> it still stinks.  It is unlikely they'll ever have the coverage
> Linux does any time soon.
>
> Frankly, if the only specific technical feature Sun has to brag
> about in Solaris 10 is DTrace, that's pretty sad.  Even more so,
> most of the bugs I see being fixed in Solaris kernel patches
> are performance regressions against Linux.  This, given how things
> were 6 or 7 years ago and the things the Solaris folks used to
> flame us for, I find particularly amusing.

What about zoning (which seems is much more than simple jailing) ? What 
about zfs which will be probably will next comparable to DTrace step 
forward ? (probably will come with next express build). On big computers 
Solaris also have much more better scaleability than Linux (I'm offen 
smile when I'm see questions like "Is Linux enterprise ready ?" ;). On 
small servers Linux is good alternative or in many cases is comparable (on 
choosing OS can decide another not stricte technical things) or is 
slightly better solution (for exemple now much more easied find well 
skilled adminis on Linux than on Solaris) but on medium or large computers 
(workgroup and higher solutions) stll in mamny cases is worse or much more 
worse solution for example in hardware utilization and needed 
funcitionalities (I'm talking about Linux vs. Solaris on sparc and also on 
x86 platform). Even on two way systems Solaris (10) still *much more*
*better* handles threads ..

For me isn't so importand how many hardware correctly handles this or 
another OS. If choosen OS handles correctly my hardware I'm quite happy
(in my case Linux still can't handle SunSwift T1000 NIC on my E250 ;o)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-1093731136-1093776312=:15099--
