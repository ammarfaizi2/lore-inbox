Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135681AbRANWkp>; Sun, 14 Jan 2001 17:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135718AbRANWkf>; Sun, 14 Jan 2001 17:40:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15374 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135681AbRANWka>; Sun, 14 Jan 2001 17:40:30 -0500
Date: Sun, 14 Jan 2001 14:40:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Gerhard Mack <gmack@innerfire.net>
cc: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101141349210.11765-100000@innerfire.net>
Message-ID: <Pine.LNX.4.10.10101141436010.4613-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Jan 2001, Gerhard Mack wrote:
> 
> PS I wish someone would explain to me why distros insist on using WU
> instead given it's horrid security record. 

I think it's a case of "better the devil you know..".

Think of all the security scares sendmail has historically had. But it's a
pretty secure piece of work now - and people know if backwards and
forward. Few people advocate switching from sendmail these days (sure,
they do exist, but what I'm saying is that a long track record that
includes security issues isn't necessarily bad, if it has gotten fixed).

Of course, you may be right on wuftpd. It obviously wasn't designed with
security in mind, other alternatives may be better.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
