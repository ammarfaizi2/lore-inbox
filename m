Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286678AbRLVEwI>; Fri, 21 Dec 2001 23:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286677AbRLVEv6>; Fri, 21 Dec 2001 23:51:58 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:2572 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S286675AbRLVEvx>;
	Fri, 21 Dec 2001 23:51:53 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112220451.fBM4pf1301592@saturn.cs.uml.edu>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
To: mharrold@cas.org (Mike Harrold)
Date: Fri, 21 Dec 2001 23:51:41 -0500 (EST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mharrold@cas.org (Mike Harrold),
        nknight@pocketinet.com, linux-kernel@vger.kernel.org
In-Reply-To: <200112211750.MAA06283@mah21awu.cas.org> from "Mike Harrold" at Dec 21, 2001 12:50:55 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Harrold writes:

>>> Yeah, no shit? The first time I buy 512MB of RAM and get 512000 KB
>>> (aka 512000000 bytes) I am gonna be *PISSED*
>>
>> Have a work with your hard disk manufacturer then
>
> That isn't quite so important. My kernel isn't likely to f*ck up when
> a 40GB HD = 40,000,000,000. I'm sure it will die quite painfully with
> RAM chips that are not powers of 2.

You'd be buying 537 MB of RAM, not 512 MB of RAM. I expect that
we will see this soon, since a binary GB has a 7% error.
(For kB the error was only 2.4%, which didn't matter so much.)

I would be selling RAM this way. It's stupid to do otherwise.
Consumers will prefer the bigger numbers.

Prefixes need to align with our number system. Unfortunately we
don't use something sane like hex. We use decimal, which is as
bad as base-9 or base-14. Oh well. Historical reasons you know,
and computers aren't bit-wise addressable either. We live with
this brokenness and can't afford to fix it all. So we might as
well use a notation, the base-10 prefixes, that is consistent
with our cummy number system.


