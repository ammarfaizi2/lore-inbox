Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133036AbRA1Agx>; Sat, 27 Jan 2001 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135978AbRA1Agn>; Sat, 27 Jan 2001 19:36:43 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:7057 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S133036AbRA1Agf>; Sat, 27 Jan 2001 19:36:35 -0500
Message-ID: <3A736979.C12CCC04@Home.net>
Date: Sat, 27 Jan 2001 19:36:09 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <3A7295F6.621BBEC4@Home.com> <3A731E65.8BE87D73@pobox.com> <3A7359BB.7BBEE42A@linux.com> <94voof$17j$1@penguin.transmeta.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This system is the following:

AcerOPEN AP53/AX Motherboard, Intel Pentium 200Mhz w/o MMX (1996-1997)
Chipsets: 430HX, PIIX3 (EIDE)

64MB RAM EDO 60ns (Kingston brand)


Linus Torvalds wrote:

> In article <3A7359BB.7BBEE42A@linux.com>, David Ford  <david@linux.com>
> wrote:
> >
> >We've narrowed it down to "we're all running xmms" when it happend.
>
> Does anybody have a clue about what is different with xmms?
>
> Does it use KNI if it can, for example? We used to have a problem with
> KNI+Athlons, for example.
>
> It might also be that it's threading-related, and that XMMS is one of
> the few things that uses threads. Things like that. I'm not an XMMS
> user, can somebody who knows XMMS comment on things that it does that
> are unusual?
>
>                 Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
