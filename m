Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbRAET54>; Fri, 5 Jan 2001 14:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129641AbRAET5q>; Fri, 5 Jan 2001 14:57:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30739 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129765AbRAET5k>;
	Fri, 5 Jan 2001 14:57:40 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101051933.f05JXAT17275@flint.arm.linux.org.uk>
Subject: Re: Announce: modutils 2.4.0 is available
To: anuradha@bee.lk (Anuradha Ratnaweera)
Date: Fri, 5 Jan 2001 19:33:10 +0000 (GMT)
Cc: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101052200380.2574-100000@bee.lk> from "Anuradha Ratnaweera" at Jan 05, 2001 10:10:02 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anuradha Ratnaweera writes:
> The reason I was looking for the debian package was to test 2.4 on a
> "stable" debian system. If I install modutils from source, package
> management system (dpkg/apt) will not know its existence.

Can't you get the source, and whatever relevent files you need to build
a dpkg and build the source + binary packages yourself (with maybe a few
minor changes to the dpkg build information)?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
