Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135183AbRAHWUx>; Mon, 8 Jan 2001 17:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbRAHWUm>; Mon, 8 Jan 2001 17:20:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17937 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130516AbRAHWUj>;
	Mon, 8 Jan 2001 17:20:39 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101082214.WAA00962@raistlin.arm.linux.org.uk>
Subject: Re: The advantage of modules?
To: goemon@anime.net (Dan Hollis)
Date: Mon, 8 Jan 2001 22:14:25 +0000 (GMT)
Cc: meissner@spectacle-pond.org (Michael Meissner), ookhoi@dds.nl (Ookhoi),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101081414020.19299-100000@anime.net> from "Dan Hollis" at Jan 08, 2001 02:16:05 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis writes:
> On Mon, 8 Jan 2001, Russell King wrote:
> > I don't believe that is what it's trying to say.  There have been instances
> > in the past where unplugging a SCSI device from a powered on SCSI bus can
> > result in blown terminator power fuses and the like.  Whether this still
> > applies today, I don't know (are active terminators better or worse than
> > passive when it comes to this type of thing?)
> 
> The term SCSI is depreciated as purely a physical layer. We talk SCSI over
> many different physical layers (1394, usb, ata). Of course many of these
> support hot plug natively.

And can you please explain how I can attach this USB Zip drive to this
50-wire SCSI bus please?  Or would you prefer me to call it a bus?
Something with 4 wheels maybe?  Maybe we should depreciate the term "bus"
as well just to remove that confusion. ;)

Seriously though, you can't depreciate a term for referring to a type of
bus without providing some other term to describe said bus.
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
