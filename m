Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131080AbQLQNdC>; Sun, 17 Dec 2000 08:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131495AbQLQNcx>; Sun, 17 Dec 2000 08:32:53 -0500
Received: from cpe.atm0-0-0-121118.boanxx2.customer.tele.dk ([195.249.94.150]:13165
	"HELO server3.home.mgs") by vger.kernel.org with SMTP
	id <S131080AbQLQNck>; Sun, 17 Dec 2000 08:32:40 -0500
Message-ID: <3A3CB8D3.B6FA50CF@mirrormind.com>
Date: Sun, 17 Dec 2000 14:00:03 +0100
From: Simon Lodal <simonl@mirrormind.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Sound (emu10k1) broken in 2.2.18
In-Reply-To: <20001215215031.A743@cascade.cs.ubc.ca> <20001216105823.H3199@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Do you have emu10k1 compiled in, or as a module?
> - Does your SBLive appear to have been detected?  (Check 'dmesg')
> - If emu10k1 is a module, is the module loaded?  Does it seem to detect
>   your SBLive when loaded?  (Again check 'dmesg')

On my machine emu10k1 works as a module, but not at all when compiled
in. When I had it compiled in I didn't notice if the card was detected.
It surely worked as compiled in with 2.2.17, but not with 2.2.18.

Too, the bass and treble controls seem to have vanished in 2.2.18, they
do not show up in any mixer apps anymore.

Simon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
