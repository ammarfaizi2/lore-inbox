Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317994AbSHaTuW>; Sat, 31 Aug 2002 15:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSHaTuW>; Sat, 31 Aug 2002 15:50:22 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:13546 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S317994AbSHaTuV>;
	Sat, 31 Aug 2002 15:50:21 -0400
Date: Sat, 31 Aug 2002 21:54:48 +0200
From: bert hubert <ahu@ds9a.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: FIXED in bitkeeper tree: Re: keyboard slowdown regression in 2.5.32 (right .config) Re: FIXED in 2.5.29 Re: keyboard ONLY functions in 2.5.27 with local APIC on for UP
Message-ID: <20020831195447.GB9522@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20020720222905.GA15288@outpost.ds9a.nl> <20020728204051.A15238@ucw.cz> <20020728203211.GA20082@outpost.ds9a.nl> <20020831182645.GA8812@outpost.ds9a.nl> <20020831205337.A65739@ucw.cz> <20020831191432.GA9522@outpost.ds9a.nl> <20020831211922.C67247@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020831211922.C67247@ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 09:19:22PM +0200, Vojtech Pavlik wrote:

> > > Can you check with the attached patch? Or (better) Linus's current BK
> > > tree?
> > 
> > When I refind Rik van Riel's bk-to-patch directory, I'll give it a shot.
> > Again, thanks!

Thanks to Rik's bitkeeper script, I can confirm that my problem is gone in
the bitkeeper tree as of a few hours ago.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
