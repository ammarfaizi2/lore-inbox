Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLaD4u>; Sat, 30 Dec 2000 22:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbQLaD4k>; Sat, 30 Dec 2000 22:56:40 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:59776 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S129436AbQLaD4c>;
	Sat, 30 Dec 2000 22:56:32 -0500
Message-ID: <3A4EA74B.EE858170@pobox.com>
Date: Sat, 30 Dec 2000 19:26:04 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre7...
In-Reply-To: <Pine.LNX.4.10.10012301910420.1904-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Sat, 30 Dec 2000, Steven Cole wrote:
> >
> > It looks like 2.4.0-test13-pre7 is a clear winner when running dbench 48
> > on my somewhat slow test machine (450 Mhz P-III, 192MB, IDE).
>
> This is almost certainly purely due to changing (some would say "fixing")
> the bdflush synchronous wait point.
>

After evaluating test13-pre7 with the quake 3 arena test,
I think it's even snappier than the previous champ, which
was test10 + low latency patches..

A most auspicious trend, if I might make so bold as
to state it in this forum.

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
