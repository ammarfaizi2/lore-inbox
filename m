Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131461AbRC0SDS>; Tue, 27 Mar 2001 13:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131466AbRC0SC6>; Tue, 27 Mar 2001 13:02:58 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:17169 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S131461AbRC0SCt>;
	Tue, 27 Mar 2001 13:02:49 -0500
Date: Tue, 27 Mar 2001 13:02:26 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: James Lewis Nance <jlnance@intrex.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel QA
In-Reply-To: <20010327085142.A982@bessie.dyndns.org>
Message-ID: <Pine.LNX.4.30.0103271301020.2551-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I disagree, 2.4.x is "stable" and as such we need as many people to use
the kernels to see whats wrong with them. 2.4  *DOES* Work, I've had very
small problems (ok, the thread hanging issue was a big one) but other then
that It's been solid.

It depends on the hardware.

Shawn.

On Tue, 27 Mar 2001, James Lewis Nance wrote:

> On Tue, Mar 27, 2001 at 12:13:32AM -0800, David Konerding wrote:
>
> > No, the point is that the linux developers should regression test their
> > code BEFORE
> > releasing it to the public as a version like "2.4.2".  When I see a
> > version like "2.4.2", I have an expectation that all the stupid little
> > problems (like mounting loopback filesystem) have already been found.
>
> You bring up a good point.  We call the even branches the stable branches
> and we do other things that promote the idea that people should be able to
> download a 2.even.X kernel, install it on their machine, and expect it to
> work.  I think we need to back away from this idea.  It seems to me that
> the real (perhaps not the intended) function of kernel releases is keeping
> kernel developers in sync.  Promoting the idea that they are thought to be
> suitable for production use just gets us in trouble.
>
> Instead I think we need to encourage people who want to use Linux,
> rather than develop it, to use kernels from a distribution.  After all,
> the distributors put a lot of effort into doing QA and putting together a
> compatable system, we should leverage that.  We need to ensure that people
> know that when they install the latest kernel from Linus, they are the QA.
>
> Please note that I am not trying to say that we should not try and
> make the kernels we release as good as possible.  It certainly makes
> things a lot better for everyone if bugs dont get introduced by new
> kernel versions.  I do think we need to be more explicit about exactly
> what people should and should not be able to expect from a "Linus kernel".
>
> Thanks,
>
> Jim
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

