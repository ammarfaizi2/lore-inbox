Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278108AbRKHM1S>; Thu, 8 Nov 2001 07:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278041AbRKHM1J>; Thu, 8 Nov 2001 07:27:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11280 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277317AbRKHM0z>; Thu, 8 Nov 2001 07:26:55 -0500
Date: Thu, 8 Nov 2001 13:26:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011108132639.A14160@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011106111723.C26034@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0111062347080.16087-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111062347080.16087-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> least as KERN_DEBUG if not as KERN_NOTICE) whenever the RTC is
> >> written to. It's too important a subsystem to be left hidden like
> >> it currently is.
> 
> > This can be as well done in userland, enforced by whoever does rtc
> > writes, no?
> 
> If some idiot writes a hwclock replacement that doesn't do logging, and

Then it is *his* problem. That's not excuse for putting it into kernel.



-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
