Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129755AbRAaXUW>; Wed, 31 Jan 2001 18:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129754AbRAaXUC>; Wed, 31 Jan 2001 18:20:02 -0500
Received: from goalkeeper.d2.com ([198.211.88.26]:43094 "HELO
	goalkeeper.d2.com") by vger.kernel.org with SMTP id <S129753AbRAaXUB>;
	Wed, 31 Jan 2001 18:20:01 -0500
Date: Wed, 31 Jan 2001 15:15:09 -0800
From: Greg from Systems <chandler@d2.com>
To: linux-kernel@vger.kernel.org
Subject: Bummer...
In-Reply-To: <3A6ED741.CACC619C@zk3.dec.com>
Message-ID: <Pine.SGI.4.10.10101311509400.29904-100000@hell.d2.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been playing with the 2.4.0 kernel scince you gave me the patch for
the alphas...  

What I have found is that it tends to randomly hang...
No Panic, no OOPs, no nothing...
The machine is a PC164, Which falls under the EB164 class.
It exhibits this behaviour on both the "generic" and "eb164" cpu types
{compile option}  It doesn't even boot compiled as pc164..
I'm also seeing this problem on my A/S 4100, "Rawhide"..

My current working kernel is 2.2.18, and I am going to start playing with
the 2.4.1

Sometimes it hangs on boot {while loading network daemons} and sometimes
it will boot fine, and I will be doing a compile or something and it will
just hang...

What kind of info can I send you to help troubleshoot this more?

----------------------------------------------------------------------------

IGNOTUM PER IGNOTIUS

"Grasshopper always wrong in argument with chicken"

The "socratic approach" is what you call starting an argument by
asking questions.

The human race will begin solving it's problems on the day that it 
ceases taking itself so seriously.

                                        PRINCIPIA DISCORDIA


                Published by POEE Head Temple - San Francisco
                      " On The Future Site of Beautiful
                             San Andreas Canyon"


                                                Please do not use this
                                                document as toilet tissue
Fnord


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
