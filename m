Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129516AbQKWSv4>; Thu, 23 Nov 2000 13:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129867AbQKWSvr>; Thu, 23 Nov 2000 13:51:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19214 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129097AbQKWSvj>;
        Thu, 23 Nov 2000 13:51:39 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011230755.eAN7twl14136@flint.arm.linux.org.uk>
Subject: Re: silly [< >] and other excess
To: ragnar@jazzfree.com (Ragnar Hojland Espinosa)
Date: Thu, 23 Nov 2000 07:55:57 +0000 (GMT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001123041149.A17763@macula.net> from "Ragnar Hojland Espinosa" at Nov 23, 2000 04:11:49 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ragnar Hojland Espinosa writes:
> On Thu, Nov 23, 2000 at 12:26:30AM +0000, Russell King wrote:
> > Oh, missed this one.  Here you're wrong again.  The numbers in [< >]
> > should be looked up, and no others.  The code can look exactly like
> > a kernel address.  In this case you definitely do NOT want to have
> > them converted.
> 
> Okay.  How about just using some prefix to the hex number, such as '>'?
> It'll still save plenty of space, and would be trivial changes for the
> tools.  

That is more a question for Keith Owens, not me.  Keith is the maintainer
of ksymoops.  He has to be happy with the address highlighting.  I just
have to be happy that we don't loose ksymoops.
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
