Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbRFTUlX>; Wed, 20 Jun 2001 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbRFTUlN>; Wed, 20 Jun 2001 16:41:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59265 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264624AbRFTUlE>; Wed, 20 Jun 2001 16:41:04 -0400
Date: Wed, 20 Jun 2001 16:40:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rob Landley <landley@webofficenow.com>
cc: Tony Hoyle <tmh@magenta-netlogic.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Russell Leighton <russell.leighton@247media.com>,
        linux-kernel@vger.kernel.org, Ben Greear <greearb@candelatech.com>
Subject: Re: [OT] Threads, inelegance, and Java
In-Reply-To: <01062011105507.00776@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1010620162210.18873A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001, Rob Landley wrote:

> On Wednesday 20 June 2001 13:03, Tony Hoyle wrote:
> 
> > (Just came back from a .NET conference...  MS are currently rewriting
> > all their apps in bytecode... whoopee...  They're even porting *games*
> > to run on it.  I can see it now 'MS Flight Simulator .NET' (Requires
> > quad Pentium 4 1.6Ghz minimum) :-o )
> 

Interesting... Hmmm. The first Flight Simulator to run on a PC
ran on a 4.47 MHz PC/XT. The core state-machine ran off the BIOS
timer-tick at 18.206 ticks/second. It was written in MASM by me.
The graphics was written by many PROGRAM EXCHANGE contributors and
was written in Turbo Pascal. I was the "SysOp" of that BBS system
in the days when the Internet was nothing more than a college-to
-college experiment. 

It required 256k or RAM and had the flight dynamics of a real
Cessna 150 airplane. It was, therefore, difficult to fly.
Once it was appropriated by M$, they removed the long-mode oscillations,
the spiral instability, the roll/yaw coupling, and most of the inertial
characteristics so that any kid could fly it.

Then they sold it to millions of kids, getting enough money to
buy out competition and control the new personal computer market.

Early on, they didn't even hide the appropriated code although
it needed to be booted directly. I disassembled the core and
found exactly what I had written. Things changed of course as
the product matured.

It's probably written in Threaded-Java now (he ducks behind his keyboard).
And, that's probably why it needs 4 CPUs and a 1.xx GHz clock.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


