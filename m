Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbQKGQe5>; Tue, 7 Nov 2000 11:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbQKGQer>; Tue, 7 Nov 2000 11:34:47 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:2058 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129470AbQKGQee>;
	Tue, 7 Nov 2000 11:34:34 -0500
To: Tim Riker <Tim@Rikers.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <E13rPhi-0001ng-00@the-village.bc.nu> <3A01BB7D.B084B66@Rikers.org>
From: Jes Sorensen <jes@linuxcare.com>
Date: 07 Nov 2000 17:33:47 +0100
In-Reply-To: Tim Riker's message of "Thu, 02 Nov 2000 12:07:41 -0700"
Message-ID: <d31ywnkahg.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tim" == Tim Riker <Tim@Rikers.org> writes:

Tim> Alan Cox wrote:
>>  > 1. There are architectures where some other compiler may do
>> better > optimizations than gcc. I will cite some examples here, no
>> need to argue
>> 
>> I think we only care about this when they become free software.

Tim> This may be your belief, but I would not choose to enforce it on
Tim> everyone. Thank you for you opinion.

Then don't try to enforce proprietary compilers on the kernel
developers either. It's the developers who write the kernel and they
use gcc extensions. There is no reason to cripple the kernel to
satisfy people who wants to use proprietary software to compile it -
not our problem.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
