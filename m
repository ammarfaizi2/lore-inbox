Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288854AbSANGsW>; Mon, 14 Jan 2002 01:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288850AbSANGsK>; Mon, 14 Jan 2002 01:48:10 -0500
Received: from dsl081-053-223.sfo1.dsl.speakeasy.net ([64.81.53.223]:59265
	"EHLO starship.berlin") by vger.kernel.org with ESMTP
	id <S288854AbSANGsC>; Mon, 14 Jan 2002 01:48:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: J Sloan <jjs@pobox.com>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 07:49:57 +0100
X-Mailer: KMail [version 1.3.2]
Cc: jogi@planetzork.ping.de, Andrew Morton <akpm@zip.com.au>,
        Ed Sweetman <ed.sweetman@wmich.edu>, Andrea Arcangeli <andrea@suse.de>,
        yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010946178.11848.14.camel@phantasy> <3C41E17A.4010909@pobox.com>
In-Reply-To: <3C41E17A.4010909@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Q0wQ-0000ks-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 13, 2002 08:35 pm, J Sloan wrote:
> The problem here is that when people report
> that the low latency patch works better for them
> than the preempt patch, they aren't talking about
> bebnchmarking the time to compile a kernel, they
> are talking about interactive feel and smoothness.

Nobody is claiming the low latency patch works better than 
-preempt+lock_break, only that low latency can equal -preempt+lock_break, 
which is a claim I'm skeptical of, but oh well.

> I've no agenda other than wanting to see linux
> as an attractive option for the multimedia and
> gaming crowds - and in my experience, the low
> latency patches simply give a much smoother
> feel and a more pleasant experience. Kernel
> compilation time is the farthest thing from my
> mind when e.g. playing Q3A!

You need to read the thread *way* more closely ;-)

> I'd be happy to check out the preempt patch
> again and see if anything's changed, if the
> problem of tux+preempt oopsing has been
> dealt with -

Right, useful.

--
Daniel
