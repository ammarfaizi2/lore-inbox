Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291863AbSBARLZ>; Fri, 1 Feb 2002 12:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291857AbSBARLP>; Fri, 1 Feb 2002 12:11:15 -0500
Received: from rakis.net ([207.8.143.12]:6558 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S291863AbSBARLH>;
	Fri, 1 Feb 2002 12:11:07 -0500
Date: Fri, 1 Feb 2002 12:11:07 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Machines misreporting Bogomips 
In-Reply-To: <200202010959.g119xXH3008047@tigger.cs.uni-dortmund.de>
Message-ID: <Pine.LNX.4.42.0202011208180.3467-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Horst von Brand wrote:

> Greg Boyce <gboyce@rakis.net> said:
>
> [...]
>
> > Every once in a while we come across single machines which are running a
> > lot slower than they should be, and are misreporting their speed in
> > bogomips under /proc/cpuinfo.  Reinstalling the OS and changing versions
> > of the kernel don't appear to affect the machines themselves at all.
>
> Just misrepresented bogomips or is the machine really slower? Perhaps the
> CPU is being underclocked?
> --
> Horst von Brand			     http://counter.li.org # 22616
>

The machine is actually slower.  That's how I noticed the problem.

Underclocking dosen't seem likely due to the difference in speed.  It's 4
bogomips instead of 500.  The machine is running at about the speed of a
386 (I believe that's about right).  It almost seems as if someone turned
off the turbo button.  But of course I haven't seen one of those since my
old 486 :)

--
Greg Boyce


