Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWCILVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWCILVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWCILVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:21:45 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:37003 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1751843AbWCILVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:21:44 -0500
Date: Thu, 9 Mar 2006 12:22:59 +0100
From: DervishD <lkml@dervishd.net>
To: Rudolf Randal <rudolf.randal@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
Message-ID: <20060309112241.GC14004@DervishD>
Mail-Followup-To: Rudolf Randal <rudolf.randal@gmail.com>,
	linux-kernel@vger.kernel.org
References: <161717d50603080659t53462cd0k53969c0d33e06321@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKIELAKJAB.davids@webmaster.com> <21d7e9970603090202v22205fc6ha5b4cec12f0a0507@mail.gmail.com> <a03c9a270603090242o713fbe36s895da175bc53140f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a03c9a270603090242o713fbe36s895da175bc53140f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Rudolf :)

 * Rudolf Randal <rudolf.randal@gmail.com> dixit:
> I was wondering how many direct letters from lkml people have been
> written to vendors asking for cooperation with regard to specs,
> joint development or other solutions for open source drivers for
> their devices.

    Not exactly kernel related, but anyway: I wrote almost a month
ago to Menarini Diagnostics. They make glucometers, and the latest
model they sell can be connected to the PC with a special cable. Of
course, Windows.

    Since no Linux support is provided for this useful device, I did
an offer to Menarini: if they provided me with the cable and the
specs, I'll write a Linux driver and/or a Linux application to
support *their* product at no cost. I would do it for free because
I'm very interested in connecting my glucometer to my Linux box.

    I made clear that the driver and/or app would be GPL'd, but on
the other hand I made clear too that I won't release the specs they
would give me if they didn't want to (except of course those bits
exposed by the source code itself).

    I haven't got any answer from them. I can use other glucometer,
of course, but this one is, IMHO, the best one in the market and I
don't think any other vendor would give me specs for their products.

    And please note that I'm not talking about all the specifications
of the glucometer: they can keep secret the way the glucometer makes
the measurements, I don't give a heck about that. I only want the
*communication* specs, so I'm able to retrieve data from the
glucometer through the cable (which is USB, AFAIK, so probably it
won't need a new driver).

> I too feel strongly about oss and GPL - but the tone on this list
> (often) might be too much to handle for some people!

    Probably, but if I make something for free, I think I should have
the right to impose distribution conditions, and GPL restrictions
seem to be very reasonable to me: if you use my work, you cannot
avoid others using it, and if you make a modification of my work, you
cannot distribute a binary of that modified work without the source.

    For me, not getting an answer from a vendor is too much to
handle. Having to buy a cable myself and doing reverse engineering to
make something I own work with my operating system is too much to
handle.

    I don't know how much Menarini paid for the Windows version of
the software. Probably more than the entire Linux kernel will cost to
produce in its entire life. The cost of a Linux version for them will
be a cable and a PDF document of the communication specification,
which probably will be a known protocol. They don't want to do it
because: a) they don't understand a word of the open source movement
and how it can be used to save money; or b) they're so stupid,
stubborn and money avid that won't do anything that doesn't involve
money, even if the money goes out of their own pockets!

> Maybe request for an open discussion with some of these vendors
> would bring about some of their concerns over IP and other issues
> and could maybe even open up for some progress ??

    I utterly agree. The tone in this list may be "strong", but it is
an open list nonetheless and I think all Linux hackers out there will
be happy to hear from some vendor doing a cooperation offer.

    Up to this point, Menarini doesn't seem to be one of them,
though.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
