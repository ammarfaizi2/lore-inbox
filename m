Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280592AbRKSSs5>; Mon, 19 Nov 2001 13:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280547AbRKSSsj>; Mon, 19 Nov 2001 13:48:39 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:34825 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S280592AbRKSSrW>; Mon, 19 Nov 2001 13:47:22 -0500
Date: Mon, 19 Nov 2001 13:47:22 -0500
Message-Id: <200111191847.fAJIlMn30859@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Any lingering Athlon bugs in Kernel 2.4.14?
X-Newsgroups: linux.kernel
In-Reply-To: <Pine.LNX.4.10.10111081706491.31943-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <001b01c1689f$fdd77850$c800000a@Artifact>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10111081706491.31943-100000@coffee.psychology.mcmaster.ca>
	hahn@physics.mcmaster.ca wrote:
>> Bugs in the Athlon optimizations present in the Linux kernel.
>
>what bugs would those be?  if you're thinking of the infamous
>"my athlon dies when I boot a CONFIG_MK7 kernel on a kt133",
>it is by all accounts a *chipset* bug, not a kernel bug.
>it's still unclear whether the voodoo workaround 
>(in both linux and ac) is doing something sensible.

  Without the voodoo the Athlon is a very dubious chip to use indeed...
because user mode code can and will use Athlon optimizations which hang
the system. This is a case of "I do it because if I don't the system
doesn't work right."

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
