Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266177AbRGGN4t>; Sat, 7 Jul 2001 09:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266183AbRGGN4k>; Sat, 7 Jul 2001 09:56:40 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:14608 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S266177AbRGGN4V>; Sat, 7 Jul 2001 09:56:21 -0400
Message-ID: <3B471501.A91C77D4@damncats.org>
Date: Sat, 07 Jul 2001 09:56:17 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: arjan@fenrus.demon.nl
CC: Brian Dushaw <dushaw@apl.washington.edu>, linux-kernel@vger.kernel.org
Subject: Re: ASUS CUV4X-D Dual CPU's - Failure to boot...
In-Reply-To: <m15IndK-000OzlC@amadeus.home.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjan@fenrus.demon.nl wrote:
> 
> In article <Pine.LNX.4.33.0107062244260.3175-100000@munk.apl.washington.edu> you wrote:
> > Dear Kernel People,
> >   A friend of mine has a new PC with an ASUS CUV4X-D motherboard
> > and dual 1GHZ PIII's.
...
> For several people the following works:
> 1) Upgrade to the latest bios
> 2) Change the "MPS" level in the bios. It can have 3 values "1.4" "1.1" and
>    "none". the default one doesn't work, one of the others does (but I
>    forgot which one)

1.1 works fine for me. I haven't had a problem with this board since
upgrading the BIOS and changing the MPS version to 1.1.

You can also specify "noapic" to the booting kernel.

John
