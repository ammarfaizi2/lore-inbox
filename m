Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265884AbRFYRsb>; Mon, 25 Jun 2001 13:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265878AbRFYRsM>; Mon, 25 Jun 2001 13:48:12 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:55806 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S265884AbRFYRrw>; Mon, 25 Jun 2001 13:47:52 -0400
Date: Mon, 25 Jun 2001 12:47:48 -0500
From: Joseph Pingenot <jap3003@ksu.edu>
To: Android <android@abac.com>
Cc: John Nilsson <pzycrow@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
Message-ID: <20010625124748.D17653@ksu.edu>
Reply-To: jap3003+response@ksu.edu
Mail-Followup-To: Android <android@abac.com>,
	John Nilsson <pzycrow@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com> <5.1.0.14.2.20010624141432.00a52f38@mail.abac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: RE: [Re: Some experience of linux on a Laptop]
X-School: Kansas State University
X-vi-or-emacs: vi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Android on Sunday, 24 June, 2001:
>>I have come to the conclusion that linux is NOT suitable for the general 
>>desktop market.
>I have to disagree on this. It runs fine on most PC's, as they use standard 
>devices.  Just say NO to anything proprietary. This includes Toshiba. Makers of such 
>odd machines should supply their own native drivers if they want to be supported.

I would have to concur, if it weren't for almost all manufacturers doing this.
  Grr.

>>5: Better support for toshiba computers... well try =)
>Talk to Toshiba. See if they are willing to part with "secret" information 
>so that you can create specific drivers for Linux. After that, I bet your next comp. 
>won't be from them. :-)

I've been talking sometimes on the Toshiba list, trying to get Toshiba
  to support Linux officially (they do *unofficially*, as shown by the
  inclusion of Linux in a lot of their website).  However, it doesn't
  look likely.
I'd like everyone's help pressing Toshiba to open up some more of
  their specs.  That'd be the ideal solution.  I guess I'd go for
  binary-only drivers, if they'd maintain them well.  It's sub-optimal,
  but it's a workaround for now.  :)
If you have Toshiba hardware, *please* tell them to support Linux
  every chance you get.  Maybe after enough feedback from the
  community, they'll wise up.

Oh, FYI, I am running the unstable distribution of Debian with
  the 2.4.5 kernel.  Everything on my Satellite 1605CDS laptop works, 
  with the notable exception of the scheiss-Winmodem.  I've been
  talking with Conextant (the winmodem chipset manufacturers), so
  I'll see where that gets me.  Be sure that if I get sufficient info
  (and time!!), I'll post what I know and *maybe* even deveop a
  pseudo-serial port driver.  That'd require a *lot* of time, though,
  and time is in very short supply right now.  :)

Anyway, the basic message I wanted to convey was that you need to pressure
  your hardware manufacturer of choice to open up their specs so that
  *everyone* can use their hardware with whatever software they choose.
  It helps find bugs ("your spec says X, but the hardware *really* does
  Y"), and hey, they can hire only a minimal staff to do Linux support
  (if they offload the driver development and maintenance to the kernel
  developers.  :)
If something doesn't work with Linux, given experience and the sheer
  number of developers, chances are *very* good that the manufacturer
  is hoarding the specs.  Unfortunately, it's a common practice that
  requires a good kick in the hiney.  :)

                              -Joseph
-- 
Joseph==============================================jap3003@ksu.edu
"IBM were providing source code in the 1960's under similar terms. 
VMS source code was available under limited licenses to customers 
from the beginning. Microsoft are catching up with 1960."
   --Alan Cox,  http://www2.usermagnet.com/cox/index.html
