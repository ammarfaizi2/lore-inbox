Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129935AbQKMG6z>; Mon, 13 Nov 2000 01:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130131AbQKMG6p>; Mon, 13 Nov 2000 01:58:45 -0500
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:12228 "EHLO
	d06lmsgate.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S129935AbQKMG63>; Mon, 13 Nov 2000 01:58:29 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Andi Kleen <ak@suse.de>
cc: "Theodore Y. Ts'o" <tytso@MIT.EDU>, Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Message-ID: <80256996.00264A4F.00@d06mta06.portsmouth.uk.ibm.com>
Date: Sun, 12 Nov 2000 23:27:26 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Andi Kleen wrote:
> It will just help some people who have a unrational aversion against
kernel
>recompiles and believe in vendor blessed binaries.


An interesting remark Andi, especially in the light of your note to me
regarding your use of DProbes - i.e. you'd rather use DProbes to dump out
some info from the kernel than recompile it with printks.

I don't have an aversion to recompiling the kernel - it's great fun - I
love watching all the meeages go by, waiting with bated breath for a
compile error, which never seems to happen. Just like watching the National
Lottery, waiting for your own numbers to come up.

To be a little more serious, it's not recompilation that's a problem, its
re-working a set of (non-standard) patches together. I'm not that excited
by that - I'd rather develop new code than rework old. Anyway for a couple
of  example scenarios see the response I made to Michael Rothwell.  And by
the way, I absolutely agree with your approach to kernel problem solving -
but wouldn't it be a help if you didn't have to put a large or even
moderate effort into working the DProbes patch into some hot-off-the-press
version of the kernel?

Richard


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
