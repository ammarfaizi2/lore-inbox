Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131815AbQL1VNb>; Thu, 28 Dec 2000 16:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131813AbQL1VNU>; Thu, 28 Dec 2000 16:13:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:48909 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131627AbQL1VND>; Thu, 28 Dec 2000 16:13:03 -0500
Date: Thu, 28 Dec 2000 12:42:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <3A4BA45E.4ADEB2DF@innominate.de>
Message-ID: <Pine.LNX.4.10.10012281241240.788-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Daniel Phillips wrote:
> 
> OK, I see you just posted -pre5 while I was making the patch, but here
> it is anyway, as a cross-check.

Ok, pre-5 should have all the same places you found already fixed, but
please do give it some heavy-duty testing to make sure there isn't
anything hidden..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
