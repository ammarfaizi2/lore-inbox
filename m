Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264576AbRFPAE3>; Fri, 15 Jun 2001 20:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264575AbRFPAET>; Fri, 15 Jun 2001 20:04:19 -0400
Received: from dsl-45-169.muscanet.com ([208.164.45.169]:37645 "EHLO
	dink.joshs.apt") by vger.kernel.org with ESMTP id <S264578AbRFPAEG>;
	Fri, 15 Jun 2001 20:04:06 -0400
Date: Fri, 15 Jun 2001 19:03:56 -0500 (CDT)
From: Josh Myer <jbm@joshisanerd.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Leon Breedt <ljb@devco.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] nonblinking VGA block cursor
In-Reply-To: <0106160144400D.00879@starship>
Message-ID: <Pine.LNX.4.21.0106151854070.1755-100000@dignity.joshisanerd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2001, Daniel Phillips wrote:

> Ask the original poster if he's willing to take the risk of going with an xor 
> cursor.  We are talking text mode, right?  No way to get rid of that blinking 
> text cursor, ever.  Tell me, do you like having the colon blink on your alarm 
> clock too?  Personally, I opened the thing up and put a piece of tape over it.
> 

Aha! A software weenie! A real hardware hacker would have snipped and
soldered it to VCC to get a constant (or add a switch for solid/blink =).


In any case, this strikes me as a matter of policy. I don't care one way
or the other, but if people want a solid cursor, it's not something that 
we can really deny them that (unless it's a binary-only driver for the
cursor, of course).

Anyway, this is a silly discusson in general, i figured i would throw in
my $0.02 (strong US cents!)

> IBM had lots of ideas about how computers should work.  Remember the keyboard 
> keys that when CLACK CLACK CLACK.  Thank god they turned out to be too 
> expensive to clone - nobody misses them now.
> 

  *CLACK CLACK CLACK* 
(posted with a Model M)
--
/jbm, but you can call me Josh. Really, you can.
 "When lasers are outlawed, only outlaws will have lasers"
  -- from http://www.altair.org/CO2laser.htm

