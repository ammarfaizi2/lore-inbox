Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318982AbSIDApa>; Tue, 3 Sep 2002 20:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318987AbSIDApa>; Tue, 3 Sep 2002 20:45:30 -0400
Received: from balthasar.nuitari.net ([216.40.249.34]:37774 "HELO
	nuitari.nuitari.net") by vger.kernel.org with SMTP
	id <S318982AbSIDAp3>; Tue, 3 Sep 2002 20:45:29 -0400
Date: Wed, 4 Sep 2002 03:02:25 -0400 (EDT)
From: Nuitari <nuitari@balthasar.nuitari.net>
To: Kenneth Corbin <kencx@peak.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux consistently crashes running grip. (continued)
In-Reply-To: <200209031655.56412.kencx@peak.org>
Message-ID: <Pine.LNX.4.44.0209040257470.28297-100000@balthasar.nuitari.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Kenneth Corbin wrote:

> Long description of same problem.   Still continuing after dumping the nvidia 
> drivers and upgrading to the latest Redhat kernel.   Anything else I can do?
> 
> I am not subscribed to this list, please cc me with any response.
> Thanks in advance for wading through this.
> 
> 1. Linux consistently crashes running grip.
> 
> 2. Grip 3.0.1-1 is a graphical X frontend for a variety of CD ripper and MP3
> encoder programs.   When it is only ripping CD's everything is OK.  But when
> it is ripping and encoding tracks, the system will die shortly after the
> ripping operation finishes while the encoding operation is going on.   The
> time till death is variable, it has ranged from 5 seconds to 5 minutes on one
> occasion, but it always crashes.  It happens with two different encoders
> (notlame and oggenc) and two different rippers (cdparanoia and cdda2wav)  The
> quickest way to induce a failure is to make one pass ripping tracks and a
> second pass asking it to rip and encode.  It is smart enough to realize the
> tracks have already been ripped and doesn't do much beyond checking that they
> are all accounted for.   But my system still crashes.

> Gnu C                  2.96

Did you try testing your ram for any defects (even if it means trying 
various combinations of ram) ?
The only times I had similar problems was when I had faulty ram on my 
motherboard or (in 1 case) a really defective onboard ide controller.

Also be careful with Gcc 2.96, there is a lot of problems related to it.


