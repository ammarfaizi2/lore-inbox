Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSG2VF0>; Mon, 29 Jul 2002 17:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318060AbSG2VF0>; Mon, 29 Jul 2002 17:05:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5384 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S317918AbSG2VFZ>; Mon, 29 Jul 2002 17:05:25 -0400
Date: Mon, 29 Jul 2002 23:08:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Andrew Rodland <arodland@noln.com>, "David D. Hagood" <wowbagger@sktc.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Speaker twiddling [was: Re: Panicking in morse code]
Message-ID: <20020729210849.GD24910@atrey.karlin.mff.cuni.cz>
References: <20020729174912.C38@toy.ucw.cz> <200207292035.g6TKZgF161537@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207292035.g6TKZgF161537@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You might even add FSK checksum at each end of morse line ;-), if you realy
> > want checksum. Plus it will sound cool. You should also play special melody
> > at each start of repeat, to be more decoder-friendly [and it will also
> > sound cool].
> 
> I looked into writing a decoder. It's really helpful to have a
> fixed ratio of high/low states. It's also good to avoid silence.

If you want it to be simple, take a look at multimon. I was actually
able to communicate using beeps on pc beeper and decoded by multimon.

But morse would be way more sexy.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
