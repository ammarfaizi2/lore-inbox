Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317314AbSG1U2w>; Sun, 28 Jul 2002 16:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSG1U2w>; Sun, 28 Jul 2002 16:28:52 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:43213 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S317314AbSG1U2w>;
	Sun, 28 Jul 2002 16:28:52 -0400
Date: Sun, 28 Jul 2002 22:32:12 +0200
From: bert hubert <ahu@ds9a.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: FIXED in 2.5.29 Re: keyboard ONLY functions in 2.5.27 with local APIC on for UP
Message-ID: <20020728203211.GA20082@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20020720222905.GA15288@outpost.ds9a.nl> <20020728204051.A15238@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020728204051.A15238@ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 08:40:51PM +0200, Vojtech Pavlik wrote:

> > I find that my keyboard only works if I turn on the local APIC on UP on my
> > laptop. The only clue I see scrolling past is something about 'AT keyboard
> > timeout, not present?'. I don't have my nullmodem cable handy to check it
> > out further.

> Can you check with 2.5.29? Several bugs in the keyboard support were
> fixed.

Including mine, thanks! I just tested without local APIC on UP and my
keyboard works just fine. 

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
