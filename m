Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132337AbRBRBG2>; Sat, 17 Feb 2001 20:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132358AbRBRBGS>; Sat, 17 Feb 2001 20:06:18 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:524 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132337AbRBRBGC>; Sat, 17 Feb 2001 20:06:02 -0500
Date: Sat, 17 Feb 2001 19:06:00 -0600
To: jacob@chaos2.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [LONG RANT] Re: Linux stifles innovation...
Message-ID: <20010217190600.D28785@cadcamlab.org>
In-Reply-To: <200102171337.f1HDbwh13232@flint.arm.linux.org.uk> <Pine.LNX.4.21.0102171112370.31130-100000@inbetween.blorf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0102171112370.31130-100000@inbetween.blorf.net>; from kernel@gnifty.net on Sat, Feb 17, 2001 at 11:20:23AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jacob Luna Lundberg]
> Just out of curiosity, why can't the specification be along the lines
> of a vendor data file saying ``if you want the printer to do x then
> say y'' and ``if the printer says x then it means y''.  That ought to
> add a lot of functionality right there.

Think about it.  A spec based on what you say would be quite easy to
reverse-compile, no?  In which case, obviously the company's IP, such
as it is, is not protected.  In which case, why not just do an open
source driver and be done with it?

The concept of architecture-independent device drivers goes back to
Open Firmware.  But in that case, there is a practical consideration:
the drivers couldn't be compiled down to machine language since they
had to be accessible as-is at boot time.

Peter
