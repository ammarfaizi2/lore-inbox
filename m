Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129770AbQKZUMh>; Sun, 26 Nov 2000 15:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131876AbQKZUM1>; Sun, 26 Nov 2000 15:12:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60164 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S131776AbQKZUMS>;
        Sun, 26 Nov 2000 15:12:18 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011261941.eAQJfjp25000@flint.arm.linux.org.uk>
Subject: Re: gcc-2.95.2-51 is buggy
To: dalgoda@ix.netcom.com
Date: Sun, 26 Nov 2000 19:41:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001126133612.B7698@thune.mrc-home.org> from "Mike Castle" at Nov 26, 2000 01:36:13 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Castle writes:
> Btw, was this ever tested on other arch's?  I don't remember seeing
> anything come across this list.

Well, I've tested it on egcs-1.1.2 and RH's gcc 2.96 on ARM, both of
which appear ok.
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
