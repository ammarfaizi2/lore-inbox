Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264379AbRFNBZI>; Wed, 13 Jun 2001 21:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264383AbRFNBY6>; Wed, 13 Jun 2001 21:24:58 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:61732 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S264379AbRFNBYm>; Wed, 13 Jun 2001 21:24:42 -0400
Subject: Re: obsolete code must die
From: Robert Love <rml@tech9.net>
To: Alan Olsen <alan@clueserver.org>
Cc: Daniel <ddickman@nyc.rr.com>, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10106131903190.16254-100000@clueserver.org>
In-Reply-To: <Pine.LNX.4.10.10106131903190.16254-100000@clueserver.org>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 13 Jun 2001 21:24:42 -0400
Message-Id: <992481885.7126.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jun 2001 19:22:38 -0700, Alan Olsen wrote:
> On Wed, 13 Jun 2001, Daniel wrote:
> <snip>
> > ISA bus, MCA bus, EISA bus
> > PCI is the defacto standard. Get rid of CONFIG_BLK_DEV_ISAPNP,
> > CONFIG_ISAPNP, etc
> 
> This I strongly disagree with.
> 
> There are alot of ISA cards still in use.  (I have a USR 56k voice/fax
> modem that still works great. How many Sound Blaster 16 cards are still
> being used? Lots, i would guess.)
> <snip>

i think we are all missing the ball here: i am happy when i see driver
support for a piece of hardware that i have _NEVER_ heard of and at most
_ONE_ person uses it.  why?  it means more stuff works in linux.  we
dont need to defend how many people use hardware X.  if you have X, good
for you.  if not, you dont care, but at least good for linux as a whole.

driver support does not effect me if i dont use said driver.

in an ideal world, my kernel is super-small (ultra-optimized code) but
the full kernel source is huge (lots of platform and driver support).

lets stop fanning the flames and let this (Microsoft-using, as Rik
pointed out) troll die off.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

