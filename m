Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157241-25208>; Mon, 8 Mar 1999 11:55:28 -0500
Received: by vger.rutgers.edu id <157187-25206>; Mon, 8 Mar 1999 11:54:22 -0500
Received: from MERCURY.CS.UREGINA.CA ([142.3.200.53]:13201 "EHLO MERCURY.CS.UREGINA.CA" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157350-25208>; Mon, 8 Mar 1999 11:53:24 -0500
Date: Mon, 8 Mar 1999 12:12:08 -0600 (CST)
From: Kamran Karimi <karimi@cs.uregina.ca>
To: Linux-kernel@vger.rutgers.edu
Subject: DIPC development invitation
Message-ID: <Pine.SGI.3.91.990308115349.28440A-100000@MERCURY.CS.UREGINA.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Hi Everybody,

 I publicly invite all the people interested in distributed systems 
development to start working on DIPC (Distributed Inter-Process 
Communication) in any way they see fit. This could be porting DIPC to 
as-yet unsupported processors, adding features to increase its 
performance/security/availability/etc. or even using the code (or ideas) in 
other related projects.

 There can be different "flavours" of DIPC, with different trade-offs 
like using link libraries for DIPC's messages and semaphores. In this 
example, we are asking the programmer to use a link library but at the 
same time avoiding a (costly) round-trip in and out of the kernel.

 Consider it a test bed for further experiments (academical or commercial), 
and don't worry about my copyright notices in the code (but do acknowledge 
the roots! :-)

 Maybe there will be a DIPC II with much more goodies (and different 
trade-offs)

-Kamran Karimi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
