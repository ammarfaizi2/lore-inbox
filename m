Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSFENZY>; Wed, 5 Jun 2002 09:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSFENZX>; Wed, 5 Jun 2002 09:25:23 -0400
Received: from [212.3.242.3] ([212.3.242.3]:2296 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S315417AbSFENZW>;
	Wed, 5 Jun 2002 09:25:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre10-ac1
Date: Wed, 5 Jun 2002 15:25:04 +0200
User-Agent: KMail/1.4.1
In-Reply-To: <200206050000.g5500vl24470@devserv.devel.redhat.com> <200206051501.13086.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206051525.04983.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 15:01, DevilKin wrote:
> On Wednesday 05 June 2002 02:00, Alan Cox wrote:
> > [+ indicates stuff that went to Marcelo, o stuff that has not,
> >  * indicates stuff that is merged in mainstream now, X stuff that proved
> >    bad and was dropped out]
> >
> > Linux 2.4.19pre10-ac1
> > o	Merge with Linux 2.4.19-pre10
> >
> > Linux 2.4.19pre9-ac3
> > o	Cpufreq updates			(Dominik Brodowski, Dave Jones0
> >
> > 	| Now includes some reverse engineered speedstep support
>
> Currently i get 'your processor is not supported' when activating this
> speedstep stuff. Can I in any way help supplying values or smthing for
> this? Or test code?
>
> I have a Mobile Pentium 2 @ 366mhz.
>

Nevermind - I looked at Intel's site and it seems that only P3 and higher 
support speedstep.

(/me thwaps himself)

DK
-- 
Slick's Three Laws of the Universe:
	(1) Nothing in the known universe travels faster than a bad
	    check.
	(2) A quarter-ounce of chocolate = four pounds of fat.
	(3) There are two types of dirt: the dark kind, which is
	    attracted to light objects, and the light kind, which is
	    attracted to dark objects.

