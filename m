Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291983AbSBAUgO>; Fri, 1 Feb 2002 15:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291982AbSBAUf5>; Fri, 1 Feb 2002 15:35:57 -0500
Received: from 216-21-153-9.ip.van.radiant.net ([216.21.153.9]:55310 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S291983AbSBAUfl>;
	Fri, 1 Feb 2002 15:35:41 -0500
Date: Fri, 1 Feb 2002 12:59:23 +0000 (/etc/localtime)
From: <gmack@innerfire.net>
To: Greg Boyce <gboyce@rakis.net>
cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Machines misreporting Bogomips 
In-Reply-To: <Pine.LNX.4.42.0202011208180.3467-100000@egg>
Message-ID: <Pine.LNX.4.21.0202011258150.12383-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Feb 2002, Greg Boyce wrote:

> Date: Fri, 1 Feb 2002 12:11:07 -0500 (EST)
> From: Greg Boyce <gboyce@rakis.net>
> To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Machines misreporting Bogomips 
> 
> On Fri, 1 Feb 2002, Horst von Brand wrote:
> 
> > Greg Boyce <gboyce@rakis.net> said:
> >
> > [...]
> >
> > > Every once in a while we come across single machines which are running a
> > > lot slower than they should be, and are misreporting their speed in
> > > bogomips under /proc/cpuinfo.  Reinstalling the OS and changing versions
> > > of the kernel don't appear to affect the machines themselves at all.
> >
> > Just misrepresented bogomips or is the machine really slower? Perhaps the
> > CPU is being underclocked?
> > --
> > Horst von Brand			     http://counter.li.org # 22616
> >
> 
> The machine is actually slower.  That's how I noticed the problem.
> 
> Underclocking dosen't seem likely due to the difference in speed.  It's 4
> bogomips instead of 500.  The machine is running at about the speed of a
> 386 (I believe that's about right).  It almost seems as if someone turned
> off the turbo button.  But of course I haven't seen one of those since my
> old 486 :)
> 
> --
> Greg Boyce
> 
> 

Could they be running with cache disabled in the bios?


 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

