Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154259-10761>; Tue, 8 Sep 1998 16:38:57 -0400
Received: from raptor.cqi.com ([205.252.44.227]:25240 "EHLO raptor.cqi.com" ident: "humbubba") by vger.rutgers.edu with ESMTP id <156089-10761>; Tue, 8 Sep 1998 15:24:32 -0400
From: RHS Linux User <humbubba@raptor.cqi.com>
Message-Id: <199809082124.RAA16169@raptor.cqi.com>
Subject: HW hacks links
To: linux-kernel@vger.rutgers.edu
Date: Tue, 8 Sep 1998 17:24:36 -0400 (EDT)
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu






Here's a couple of things I find interesting that may be of interest 
to hardware hackers.

Charles Moore "discovered" Forth around 1970. He left Forth Inc. a while ago to do hardware. Forth has a concise simple 2 stack virtual machine that makes a
fine real machine. Chuck has done the ShBoom, the Harris RTX, and now the MuP21.
I think the only 32 bit Forth engine is still the FRISC from Johns Hopkins APL.
Chuck's outfit is called Computer Cowboys. Offete enterprises is one related 
outfit, and Ultra Technology is another. Related links are at 
http://www.dnai.com/~jfox   .

These are tiny machines without luxuries like integer-multiply. They scream 
though. And you can get dozens of em on one die. In your kitchen. Kinda.


With all due respect to the assembled wizards of C/unix, the ultimate one-stack
machine, 2 stacks is better. I'm looking into 3.
Forth machines ARE what RISC was supposed to be.

I'm told the original Cisco router was basically a Moto devel board for thier
QUICC microcontroller. I had a mailserver for a while to discuss a from-scratch
Forth-oriented platform based on the MC690360 QUICC, which is a E68020 and a
dedicated RISC to handle the 7 on-chip IO Ports. There is now a PPC version
of the QUICC, with the same RISC and IO ports. AN outtake from the outline of
the progress of the "FIRE Proposal" mailserver is at 
http://cqi.com/~humbubba/fire8.htm     

Sorry about the topic-skew, but this seems to be a major side-topic.


Rick Hohensee          http://cqi.com/~humbubba
colorg on EFnet IRC    #linux chanop
Forth  C   Linux   Perl graphics   music    Md., USA
This is your brain on colorg --> (@#*%@#() <---~~~_()()(
Any questions?




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
