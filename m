Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283730AbRK3SEB>; Fri, 30 Nov 2001 13:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283738AbRK3SDy>; Fri, 30 Nov 2001 13:03:54 -0500
Received: from [212.18.232.186] ([212.18.232.186]:29957 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283744AbRK3SDZ>; Fri, 30 Nov 2001 13:03:25 -0500
Date: Fri, 30 Nov 2001 18:03:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: dalecki@evision.ag
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011130180312.D19193@flint.arm.linux.org.uk>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <3C07BFE8.5B32C49C@evision-ventures.com> <20011130175058.B19193@flint.arm.linux.org.uk> <3C07C68D.67D60384@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C07C68D.67D60384@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Nov 30, 2001 at 06:49:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 06:49:01PM +0100, Martin Dalecki wrote:
> Well sombeody really cares apparently! Thank's.

Currently its a restructuring of serial.c to allow different uart type
ports to be driven without duplicating serial.c many times over.  (the
generic_serial didn't hack it either).

> Any pointers where to ahve a look at it?

I should probably put this on a web page somewhere 8)

  :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot, module serial
  (no password)

> BTW> Did you consider ther misc device idea? (Hooking serial at to the
> misc device stuff).

I just caught that comment - I'll await your reply.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

