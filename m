Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136312AbRASBfW>; Thu, 18 Jan 2001 20:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136632AbRASBe6>; Thu, 18 Jan 2001 20:34:58 -0500
Received: from gateway.sequent.com ([192.148.1.10]:65452 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S136629AbRASBeq>; Thu, 18 Jan 2001 20:34:46 -0500
Date: Thu, 18 Jan 2001 17:34:35 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010118173435.K8637@w-mikek.des.sequent.com>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <20010119012616.D32087@athlon.random> <20010118165225.E8637@w-mikek.des.sequent.com> <20010119023041.F32087@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010119023041.F32087@athlon.random>; from andrea@suse.de on Fri, Jan 19, 2001 at 02:30:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 02:30:41AM +0100, Andrea Arcangeli wrote:
> On Thu, Jan 18, 2001 at 04:52:25PM -0800, Mike Kravetz wrote:
> > was less than the number of processors.  I'll give the tests a try
> > with a smaller number of threads.  I'm also open to suggestions for
> 
> OK!
> 
> > what benchmarks/test methods I could use for scheduler testing.  If
> > you remember what people have used in the past, please let me know.
> 
> It was this one IIRC (it spawns threads calling sched_yield() in loop).

Thanks!

At first glance this looks to be the same type of test/benchmark
I have been using.

-
Mike
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
