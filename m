Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133003AbRAGPBt>; Sun, 7 Jan 2001 10:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133051AbRAGPBk>; Sun, 7 Jan 2001 10:01:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26892 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S133003AbRAGPB1>;
	Sun, 7 Jan 2001 10:01:27 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101071502.f07F2vY08119@flint.arm.linux.org.uk>
Subject: Re: [PATCH] new bug report script
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 7 Jan 2001 15:02:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14FGfM-0002jO-00@the-village.bc.nu> from "Alan Cox" at Jan 07, 2001 02:19:21 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > ./arch/arm/lib/extractconstants.pl
> 
> None of these are needed for normal build/use/bug reporting work. In fact
> if you look at script_asm you'll see we go to great pains to ship prebuilt
> files too

Whoops. ;(

I've already got a fix for this one though using grep and sed.
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
