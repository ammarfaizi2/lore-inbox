Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQKHG5w>; Wed, 8 Nov 2000 01:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKHG5d>; Wed, 8 Nov 2000 01:57:33 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:53510 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129043AbQKHG53>; Wed, 8 Nov 2000 01:57:29 -0500
Date: Tue, 7 Nov 2000 22:57:49 -0800
From: Richard Henderson <rth@twiddle.net>
To: Reto Baettig <baettig@scs.ch>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Alpha SMP problem
Message-ID: <20001107225749.B26542@twiddle.net>
In-Reply-To: <3A08455E.F3583D1B@scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A08455E.F3583D1B@scs.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 10:09:34AM -0800, Reto Baettig wrote:
> I have a problem whith Alpha SMP's which seems to be kernel-related. I
> discussed this on the bug-glibc list but everybody seems to agree that
> it cannot be a libc problem.

Indeed it does seem to be some sort of tlb flushing problem,
but I've been unable to figure out exactly what.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
