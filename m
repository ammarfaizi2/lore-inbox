Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274505AbRIXTLO>; Mon, 24 Sep 2001 15:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274660AbRIXTLF>; Mon, 24 Sep 2001 15:11:05 -0400
Received: from oe53.pav1.hotmail.com ([64.4.30.46]:5135 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S274505AbRIXTKs>;
	Mon, 24 Sep 2001 15:10:48 -0400
X-Originating-IP: [12.19.166.64]
From: "Dan Mann" <daniel_b_mann1@hotmail.com>
To: "VDA" <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010916204528.6fd48f5b.skraw@ithnet.com> <Pine.LNX.3.96.1010920231251.26679B-100000@gatekeeper.tmr.com> <20010921124338.4e31a635.skraw@ithnet.com> <20010922105332Z16449-2757+1233@humbolt.nl.linux.org> <6514162334.20010924123631@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Linux VM design
Date: Mon, 24 Sep 2001 15:11:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE53f3LSW50Pfs56PHo00002624@hotmail.com>
X-OriginalArrivalTime: 24 Sep 2001 19:11:09.0556 (UTC) FILETIME=[AB291B40:01C1452C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this isn't the wrong place to ask this but,  wouldn't it be better to
increase ram size and decrease swap size as memory requirements grow?  For
instance, say I have a lightly loaded machine, that has 192MB of ram.  From
everything I've heard in the past, I'd use roughly 192MB of swap with this
machine.  The problem I would imagine is that if all 192MB got used wouldn't
it be terribly slow to read/write that much data back in?  Would less swap,
say 32 MB make the kernel more restrictive with it's available memory and
make the box more responsive when it's heavily using swap?

Or am I way off and just smoking crack?  (which I may very well be)

This damn mailing list is addictive.  Now I read it at work.

Dan
