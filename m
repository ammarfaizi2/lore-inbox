Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSIORol>; Sun, 15 Sep 2002 13:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSIORol>; Sun, 15 Sep 2002 13:44:41 -0400
Received: from franka.aracnet.com ([216.99.193.44]:2780 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S318141AbSIORok>; Sun, 15 Sep 2002 13:44:40 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Rik van Riel" <riel@conectiva.com.br>, "Andrew Morton" <akpm@digeo.com>
Cc: "Axel Siebenwirth" <axel@hh59.org>, "Con Kolivas" <conman@kolivas.net>,
       "lkml" <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       <lse-tech@lists.sourceforge.net>
Subject: RE: 2.5.34-mm4
Date: Sun, 15 Sep 2002 10:49:29 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBAEAHFGAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44L.0209151438030.1857-100000@imladris.surriel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Borasky's Corollary 1: If you *can* measure it and it *does* exist, the
cheapest solution may still be to buy more memory, more disks or a faster
processor.

Borasky's Corollary 2: When you try to measure the performance of people the
way you measure performance of computers, you need psychological help.

M. Edward (Ed) Borasky
mailto: znmeb@borasky-research.net
http://www.pdxneurosemantics.com
http://www.meta-trading-coach.com
http://www.borasky-research.net

Coaching: It's Not Just for Athletes and Executives Any More!

-----Original Message-----
From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org]On Behalf Of
Rik van Riel
Sent: Sunday, September 15, 2002 10:39 AM
To: Andrew Morton
Cc: Axel Siebenwirth; Con Kolivas; lkml; linux-mm@kvack.org;
lse-tech@lists.sourceforge.net
Subject: Re: 2.5.34-mm4

On Sun, 15 Sep 2002, Andrew Morton wrote:
> Axel Siebenwirth wrote:

> > I have seen that it used more swap that usual.
>
> 2.5 is much more swaphappy than 2.4.  I believe that this is actually
> correct behaviour for optimum throughput.  But it just happens that
> people (me included) hate it.

Time for a corollary to "if you can't measure it, it doesn't exist":

"If you can't measure desktop performance, our method of development
 will ensure it won't exist"

cheers,

Rik
--
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/         http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/

