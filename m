Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaN63>; Sun, 31 Dec 2000 08:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLaN6T>; Sun, 31 Dec 2000 08:58:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36876 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129324AbQLaN6H>; Sun, 31 Dec 2000 08:58:07 -0500
Subject: Re: path MTU bug still there?
To: swmike@swm.pp.se (Mikael Abrahamsson)
Date: Sun, 31 Dec 2000 13:29:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0012311409390.14553-100000@uplift.swm.pp.se> from "Mikael Abrahamsson" at Dec 31, 2000 02:12:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14CiYQ-00080O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How is this solved? Personally, I am behind a CIPE tunnel with an MTU of
> 1442 or something like that. I experienced problems to some places and

You have to get the other end to fix it.

> Could it be some kind of incompability at the tunnel level that make you
> unable to receive large packets over the tunnel? Have you tcpdump:ed to
> see if the tunnel packets actually make it the way they should?

Its normally seriously incompetent firewall admins on remote sites. Most large
ecommerce sites have these kind of basic errors. Makes you glad to trust your
credit card details to them doesnt it 8)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
