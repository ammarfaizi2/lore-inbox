Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKIMUy>; Thu, 9 Nov 2000 07:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129163AbQKIMUo>; Thu, 9 Nov 2000 07:20:44 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:59145 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129057AbQKIMUh>; Thu, 9 Nov 2000 07:20:37 -0500
Message-ID: <3A0A968B.85A6770E@holly-springs.nc.us>
Date: Thu, 09 Nov 2000 07:20:27 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: Larry McVoy <lm@bitmover.com>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <80256991.007632DE.00@d06mta06.portsmouth.uk.ibm.com>
		<3A09C725.6CFA0EE2@holly-springs.nc.us> <qwwn1f9lhdg.fsf@sap.com>
		<20001108235312.H22781@work.bitmover.com> <qwwzoj9k02h.fsf@sap.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> If we would not allow binary only modules I would not have such a big
> problem with that...

I'm not sure how you would do that.
 
> I understand that the one size fits all approach has some limitations
> if you want to run on PDAs up to big iron. But a framework to overload
> core kernel functions with modules smells a lot of binary only, closed
> source, vendor specific Linux on high end machines.

Since Linux is GPL, how would you stop this?
 
> And then I don't see the value of Linux anymore.

Same as before -- freedom and low cost. The primary advantae of Linux
over other OSes is the GPL. 

I think and Advanced Linux Kernel PRoject would be a good idea for a
number of reasons. It would give "Enterprise" users their own special
kernel, just like the microcontroller and real-time guys have. It would
also provide a parallel development track for Linux that could provide
real competition and value to the Linus-version kernel. The "Enterprise"
machines that IBM, HP and SGI would target aren't all S/390s; there
would be significant overlap of their low end with Linus' high end, I
think. Like 8+-way SMP servers.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
