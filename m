Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263963AbRFRNpL>; Mon, 18 Jun 2001 09:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263964AbRFRNpA>; Mon, 18 Jun 2001 09:45:00 -0400
Received: from cmr1.ash.ops.us.uu.net ([198.5.241.39]:64501 "EHLO
	cmr1.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S263963AbRFRNor>; Mon, 18 Jun 2001 09:44:47 -0400
Message-ID: <3B2E0592.B5B6D1A3@uu.net>
Date: Mon, 18 Jun 2001 09:43:46 -0400
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: Re: APM, ACPI, and Wake on LAN - the bane of my existance
In-Reply-To: <3B28F68C.BA9D83DA@uu.net> <20010615155621.D37@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek wrote:
> 
> Hi!
> 
> > anything.  So I removed the three pin cross connect that connects the
> > card to the WOL header on the motherboard.  That fixed it for a few
> > days, but now it's doing it again, even without the cable installed.
> > the only fix is to unplug the ethernet cable when I turn it off.
> 
> So turn it off by unplugging AC cord. If it comes up *without* AC plugged
> in.... Welll... Call GhostBusters.
>                                                                 Pavel

True, but I'd like to have work without having to unplug the power
everyday :)


> PS: I is possible that machine comes up after powerfail. This might be
> your proble. Without 3pin cable installed, it really should not come up
> itself.

Actually apparently it is possible with PCI 2.2 compliant cards and
motherboards.  The 3 pin wire is for backwards compatiblity with old
cards.


> --
> Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
> details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


Thanks for you input,

Alex
