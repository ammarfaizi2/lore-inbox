Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131564AbQLMPMP>; Wed, 13 Dec 2000 10:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131544AbQLMPMG>; Wed, 13 Dec 2000 10:12:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31499 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131448AbQLMPLv>; Wed, 13 Dec 2000 10:11:51 -0500
Subject: Re: USB mass storage backport status?
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Wed, 13 Dec 2000 14:42:52 +0000 (GMT)
Cc: 0@pervalidus.net (Frédéric L . W . Meunier),
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20001212215058.A3681@one-eyed-alien.net> from "Matthew Dharm" at Dec 12, 2000 09:50:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146D7P-0002q8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Okay, this must have changed somewhat recently.  When last I spoke to Alan
> Cox (the maintainer of the 2.2.x code), I told him (and he agreed) that
> this code should be marked EXPERIMENTAL.  If it's not marked thus in
> 2.2.18pre21, then it's an error and should be corrected ASAP.

It is marked experimental, but the help text is from 2.4test and doesnt
say that. The experimental option is needed and the question asked does
say (EXPERIMENTAL)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
