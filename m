Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbRGWSLM>; Mon, 23 Jul 2001 14:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267511AbRGWSLC>; Mon, 23 Jul 2001 14:11:02 -0400
Received: from Odin.AC.HMC.Edu ([134.173.32.75]:46746 "EHLO odin.ac.hmc.edu")
	by vger.kernel.org with ESMTP id <S267510AbRGWSK7>;
	Mon, 23 Jul 2001 14:10:59 -0400
Date: Mon, 23 Jul 2001 11:10:59 -0700 (PDT)
From: Nate Eldredge <neldredge@hmc.edu>
To: barbacha@Hinako.AMBusiness.com
cc: linux-kernel@vger.kernel.org
Subject: Re: PC Speaker ocassionally hangs on an FIC VA-503+ under 2.4.[567]
In-Reply-To: <Pine.LNX.4.21.0107231101110.28557-100000@odin.ac.hmc.edu>
Message-ID: <Pine.LNX.4.21.0107231107060.28557-100000@odin.ac.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I lied slightly.  It's not quite the same motherboard.  I have a FIC
PA2013 which is the ATX version of the same board.  And on mine when the
speaker beeped it would sometimes go into what looked like suspend mode
(flashing light on the front) and would not awaken until another key was
pressed.

On Mon, 23 Jul 2001, Nate Eldredge wrote:

> >     I have noticed the following problem on a system which I installed
> > on a FIC VA-503+ motherboard with a 450 Mhz K6-2 CPU. This problem is
> > consistent and is present in kernels from 2.4.5 - 2.4.7. The problem
> > is that occasionally the PC speaker will hang when making a beep. When
> > the hang occurs the beep stays on, the screen blanks out, and all
> > processing on the system appears to hang. After a few moments the
> > system appears to unhang itself, the screen returns, and everything
> > returns to normal.
> 
> Yes, I've also seen this.  Same motherboard, CPU is a K6-3 450 MHz.  I
> think I was running early 2.4.  I tried several things to fix it; I forget
> exactly what they were but none of them worked.  (I also remember seeing
> dropped keystrokes while playing DOS games that used the PC speaker.)  The
> final fix was to disable beeping in software (setterm -blength 0 on the
> console and some xset command in X.)
> 
> Definitely a hardware problem, anyway.
> 
> -- 
> Nate Eldredge
> neldredge@hmc.edu
> 
> 

-- 

Nate Eldredge
neldredge@hmc.edu

