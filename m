Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLDWWX>; Mon, 4 Dec 2000 17:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLDWWO>; Mon, 4 Dec 2000 17:22:14 -0500
Received: from windsormachine.com ([206.48.122.28]:3336 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129183AbQLDWV6>; Mon, 4 Dec 2000 17:21:58 -0500
Message-ID: <3A2C11D3.10C438B5@windsormachine.com>
Date: Mon, 04 Dec 2000 16:51:16 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Hollis <goemon@anime.net>
CC: Richard Torkar <ds98rito@thn.htu.se>, linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
In-Reply-To: <Pine.LNX.4.30.0012041332230.23404-100000@anime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed.  I've got one of these beasts running NT Server, dual 433 non o/c,
4x12.7 gig software raid. Before i put the Promise Ultra/33 card in, i was
using the HPT366.  Random lockups every couple weeks.  Stopped using the
HPT366, machine is stable now.  In hindsight, I think the HPT366 was the cause
of the Onstream 50 gig drive that locked up frequently too, before i shipped
that back to Onstream.  One thing that did help on stability was putting a cpu
fan on the chipset.

Dan Hollis wrote:

>
> Your 1 success out of maybe 500-1000 peoples failures. Not exactly a great
> average for this motherboard. BP6 is notorious for instability, HPT366 on
> it is about 50% of the problems.
>
> -Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
