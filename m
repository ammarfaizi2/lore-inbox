Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136337AbRAZS6R>; Fri, 26 Jan 2001 13:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136472AbRAZS6H>; Fri, 26 Jan 2001 13:58:07 -0500
Received: from limes.hometree.net ([194.231.17.49]:11268 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S136337AbRAZS54>; Fri, 26 Jan 2001 13:57:56 -0500
To: linux-kernel@vger.kernel.org
Date: Fri, 26 Jan 2001 18:42:22 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <94sgee$1p4$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <AFE36742FF57D411862500508BDE8DD055F6@mail.herefordshire.gov.uk>, <3A71B14D.267771A@magenta-netlogic.com>
Reply-To: hps@tanstaafl.de
Subject: Re: hotmail not dealing with ECN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tmh@magenta-netlogic.com (Tony Hoyle) writes:

> These ISPs will *not* change simply because 1% of Linux users
> complain at them.  They have been contacted about this and they know
> of the problem.  I doubt they care.

Trust me, they care. Every Admin cares. They have, however, to convice
their superiors that upgrading two (three, five, twenty?) Firewall
boxes from a 99% running IOS into a newer, untested [1] version to
benefit 1% (1%? Oh, come on. 0.1% I would say) of their users from an
IETF experimental feature.

I wouldn't boot a box that runs 90 MBit/s traffic for 24/7 on such an
occasion.

You want ECN? Get DaveM to join Microsoft and push out MS Whistler
with ECN enabled and just an obscure Registry Entry to turn it
off. You will have ECN in a blink implemented everywhere.

	Regards
		Henning

[1] as in "inhouse tested and works". I would not trust Cisco Release
    Notes on such boxes. ;-)

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
