Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313478AbSDETIn>; Fri, 5 Apr 2002 14:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSDETId>; Fri, 5 Apr 2002 14:08:33 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:24547 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S313476AbSDETIX>; Fri, 5 Apr 2002 14:08:23 -0500
Date: Fri, 5 Apr 2002 14:08:23 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
In-Reply-To: <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net>
Message-ID: <Pine.LNX.4.33.0204051403200.7124-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002 joeja@mindspring.com wrote:
[snip]
> If I have a machine that does not change from day to day hardware
> wise why when I boot the thing do I need to probe the hardware again
> and again each time?  Would passing more options on the command line
> help like all the addresses and IRQ's of known hardware?
> Wouldn't it make sense to store this data on the files system? Certainly
> if something like grub or lilo can figure out how to access a file on
> the drive the kernel could check for a 'defaults' file or something to
> get the default irq's, hardware, interrupts, etc from.  Then the kernel
> could probe these first and if the probe fails proble elsewhere for the
> device.

Eww, it sounds like all that unnecessary and problematic hardware info.
that MS Windows saves in the Registry, instead of doing the sensible
thing by asking the hardware.  Please don't go there.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
MS Windows *is* user-friendly, but only for certain values of "user".

