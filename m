Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbRCWJrU>; Fri, 23 Mar 2001 04:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130446AbRCWJrA>; Fri, 23 Mar 2001 04:47:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43276 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130442AbRCWJq6>; Fri, 23 Mar 2001 04:46:58 -0500
Subject: Re: Only 10 MB/sec with via 82c686b - FIXED
To: soda@xirr.com (SodaPop)
Date: Fri, 23 Mar 2001 09:48:07 +0000 (GMT)
Cc: egger@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0103222015490.25766-100000@xirr.com> from "SodaPop" at Mar 22, 2001 08:38:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gOAz-0004MB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wonder of wonders, I flashed the bios to the latest and greatest version.
> Current data transfer rates are 35.7 MB/sec on both udma drives, exactly
> as expected and darn close to the continuous read limits of the disks.
> The audio also started working, flawlessly.
> 
> There are other issues however - the athlon now runs significantly hotter
> at idle for one, but the most serious is that the K7 kernel optimizations
> cause horrendous kernel panics and crashes.  I'm running now on a kernel
> compiled for 386, which seems to be stable.  I'll attempt to build other
> kernels to see if I can figure out whats going on.

Check the bios update didnt leave some of the other configuration values
wrong. A 'reset to factory defaults' and resetting the stuff you need might
be a good idea. Could be it now has voltages wrong or something like that

Alan

