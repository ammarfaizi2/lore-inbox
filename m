Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281794AbRK0W2v>; Tue, 27 Nov 2001 17:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281783AbRK0W2m>; Tue, 27 Nov 2001 17:28:42 -0500
Received: from [216.151.155.121] ([216.151.155.121]:20486 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S281794AbRK0W2i>; Tue, 27 Nov 2001 17:28:38 -0500
To: "Neulinger, Nathan" <nneul@umr.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux@3ware.com'" <linux@3ware.com>
Subject: Re: Problems with 3ware 3dm and 2.4.16...
In-Reply-To: <E8139C9A62384F49A7EBF9CCCD2243C101B88A@umr-mail2.umr.edu>
From: Doug McNaught <doug@wireboard.com>
Date: 27 Nov 2001 17:28:22 -0500
In-Reply-To: "Neulinger, Nathan"'s message of "Tue, 27 Nov 2001 15:57:03 -0600"
Message-ID: <m3n117rgqh.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Neulinger, Nathan" <nneul@umr.edu> writes:

> I did try backing the 3w-xxxx.[ch] off to the version in 2.4.10, which
> didn't help. This problem occurs when built with gcc302 or rh71's kgcc (egcs
> 1.1.2).

Not that this is necessarily the problem, but neither of those
compilers is recommended for compiling 2.4.X--you should be using
2.95.3+ or Red Hat's 2.96 (with errata fixes). 

See Documentation/Changes in the kernel source tree.

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
