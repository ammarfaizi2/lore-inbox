Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQKGU7I>; Tue, 7 Nov 2000 15:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129308AbQKGU67>; Tue, 7 Nov 2000 15:58:59 -0500
Received: from ra.lineo.com ([204.246.147.10]:40396 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129111AbQKGU6l>;
	Tue, 7 Nov 2000 15:58:41 -0500
Message-ID: <3A086BAB.89A588EB@Rikers.org>
Date: Tue, 07 Nov 2000 13:52:59 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@linuxcare.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <E13rPhi-0001ng-00@the-village.bc.nu> <3A01BB7D.B084B66@Rikers.org> <d31ywnkahg.fsf@lxplus015.cern.ch>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/07/2000
 01:58:33 PM,
	Serialize complete at 11/07/2000 01:58:33 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes,

Hey how's Itanium been lately?

As was mentioned before, there are nonproprietary compilers around as
well that might be good choices. My point is that the ANSI C steering
committee is probably a more balanced forum to determine C syntax than
the gcc team. We should adopt c99 syntax where feasible, for example. I
am not asking anyone to use a proprietary compiler of they do not choose
to do so.

Jes Sorensen wrote:
> 
> >>>>> "Tim" == Tim Riker <Tim@Rikers.org> writes:
> 
> Tim> Alan Cox wrote:
> >>  > 1. There are architectures where some other compiler may do
> >> better > optimizations than gcc. I will cite some examples here, no
> >> need to argue
> >>
> >> I think we only care about this when they become free software.
> 
> Tim> This may be your belief, but I would not choose to enforce it on
> Tim> everyone. Thank you for you opinion.
> 
> Then don't try to enforce proprietary compilers on the kernel
> developers either. It's the developers who write the kernel and they
> use gcc extensions. There is no reason to cripple the kernel to
> satisfy people who wants to use proprietary software to compile it -
> not our problem.
> 
> Jes
-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
