Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156172AbQEVAHI>; Sun, 21 May 2000 20:07:08 -0400
Received: by vger.rutgers.edu id <S156168AbQEVAGs>; Sun, 21 May 2000 20:06:48 -0400
Received: from ha1.rdc1.sfba.home.com ([24.0.0.66]:45951 "EHLO mail.rdc1.sfba.home.com") by vger.rutgers.edu with ESMTP id <S156143AbQEVAGl>; Sun, 21 May 2000 20:06:41 -0400
Message-ID: <392879F3.A4AA4104@home.com>
Date: Sun, 21 May 2000 17:06:11 -0700
From: Prasanth Kumar <kumar1@home.com>
Organization: At Home Network
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: Re: /dev/random -- can I enlarge the `randomness stock'?
References: <Pine.GSO.4.10.10005211917001.14371-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Alexander Viro wrote:
> 
> On Sun, 21 May 2000, Alan Cox wrote:
> 
> > > What if you simply tuned a cheap FM receiver to just static and fed
> > > that into a soundcard. Then reading from /dev/dsp or something would
> > > return pretty good random data, right ?
> >
> > An attacker with a radio transmitter...
> 
> Faraday's cage + mic with a nasty loopback. The real problem being: you
> want a random data with known distribution and none of these methods will
> give that.
<snip>

Random number source by radioactive decay ;-)

	http://www.fourmilab.ch/hotbits/
-- 
Prasanth Kumar
kumar1@home.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
