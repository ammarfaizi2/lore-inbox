Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281820AbRKWADb>; Thu, 22 Nov 2001 19:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281825AbRKWADW>; Thu, 22 Nov 2001 19:03:22 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:11526 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S281820AbRKWADI>;
	Thu, 22 Nov 2001 19:03:08 -0500
Message-Id: <5.1.0.14.0.20011123105317.00a0c940@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 23 Nov 2001 11:03:02 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: Linux FSCP (Frequently Submitted Compilation Problems)? 
  (was:  Re: Loop.c File !!!!)
Cc: "Rob Turk" <r.turk@chello.nl>
In-Reply-To: <9ti8e5$9bl$1@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.21.0111202025290.6299-100000@brick>
 <5.1.0.14.2.20011121082413.00abadd0@pop.gmx.net>
 <5.1.0.14.0.20011122100929.009ead30@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:07 AM 22/11/01 +0100, Rob Turk wrote:
>"Stuart Young" <sgy@amc.com.au> wrote:
> > Why not do it like the current Changelog, put it in the kernel
> > repository, and make sure it hits all the mirrors. A little
> > selective advertising (eg: someone mention it on slashdot,
> > newsforge, debianplanet, etc), and people will start using it.
> > Just suffix the file with the version number, just like the
> > Changelog. Because the file will be small, it's possible that some
> > mirrors will get quick updates before they get the kernel itself.
> > This covers all the version specific problems at least.
>
>Most of the people which post without reading previous entries in the 
>newsgroupwill also not read FRB (Frequently Reported Bugs) files. I 
>actually got a greatsuggestion in from Martin Bene. He suggests putting a 
>last line in the build process which always shows up if a failure occurs 
>during kernel compiles.
>Something along the lines of 'Your kernel failed to build. Check
>www.where-ever-the-buglist-is.org for known issues with your kernel. Post 
>your problem on the kernel list if this is not a FRB'. Is this something 
>that can be done easily?

That's a good idea, but not mutually exclusive of what I was suggesting.

If fact, the two work quite well together, as the web reference (on failed 
compile) could point to the file I'm suggesting on the kernel mirrors. And 
it's hardly an issue to pull all the version info out of the kernel to 
provide a version number on the end of the file.

At the bottom of the file, have ANOTHER link to a generic FAQ about 
compilation problems (which covers all the major things like forgetting to 
install an assembler, the broken old build stuff, 'make dep' before 
compiling modules, etc). The FAQ could be on the kernel mirrors as well 
(and I don't see why not, as this is all kernel related, and definitely a 
resource that needs to be in more than one place).


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

