Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBIHKt>; Fri, 9 Feb 2001 02:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129030AbRBIHKk>; Fri, 9 Feb 2001 02:10:40 -0500
Received: from mhub5.tc.umn.edu ([160.94.218.235]:24553 "EHLO mhub5.tc.umn.edu")
	by vger.kernel.org with ESMTP id <S129026AbRBIHKX>;
	Fri, 9 Feb 2001 02:10:23 -0500
From: "David Carlson" <thecubic@bigfoot.com>
To: <linux-kernel@vger.kernel.org>
Subject: multiple 3c509 problems
Date: Fri, 9 Feb 2001 01:12:27 -0600
Message-Id: <GPEELJPKKIFGMCOACOLLEELCCDAA.thecubic@bigfoot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've been experiencing numerous problems with the 3c509 driver in 2.4.1.
When I force it to go to both cards (ether=10,0x300,eth0
ether=11,0x210,eth1), they both act strange (and also claim to be BNC when
they are both TP).  The link light at the hub flashes three times
repeatedly.

Donald Becker thinks it is a problem specific to the conversion to 2.4

Dave Carlson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
