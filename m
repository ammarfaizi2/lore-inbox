Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129758AbRBOLeS>; Thu, 15 Feb 2001 06:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRBOLeI>; Thu, 15 Feb 2001 06:34:08 -0500
Received: from mail08.voicenet.com ([207.103.0.34]:19424 "HELO mail08")
	by vger.kernel.org with SMTP id <S129758AbRBOLdz>;
	Thu, 15 Feb 2001 06:33:55 -0500
Message-ID: <3A8BBE90.90F52B2A@voicenet.com>
Date: Thu, 15 Feb 2001 06:33:36 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael B. Allen" <mballen@erols.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA chipset problems with 2.2?
In-Reply-To: <20010215035411.A1599@angus.foo.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael B. Allen" wrote:

> Hello,
>
> What's the nature of the VIA chipset problems? I want to get a new system
> this weekend but I read on kernel traffic that VIA has problems? I
> wan't to use Hendrick's ide patches on 2.2.18. What board should I
> get? Help, I've searched through usenet and asked on #linux without
> anything conclusive.

There are no problems with 2.2.x.  What motherboard you get depends on how
much you want to spend and on what type of athlon cpu you want to get.  K7-2
(classic), get the KA7 by abit.   Duron and T-bird should get KT7 or
something like that .    I'd use alan cox's latest patch. They work great.
Awesome performance. As good as linux gets.



>
> Thanks,
> Mike
>
> >From KT:
>
> David Riley [*] reported tremendous slowdowns in 2.4.1-pre11 and -pre12
> on his Athlon 900 with a KT133 chipset. Mark Hahn [*] replied, "this is
> known: Linus decreed that, since two people reported disk corruption
> on VIA, any machine with a VIA southbridge must boot in stupid 1992
> mode (PIO). (yes, it might be possible to boot with ide=autodma or
> something, but who would guess?)" He added to Linus Torvalds [*],
> "I hope you don't consider this a releasable state! VIA now owns 40%
> of the chipset market..." Linus replied:
>
>   So find somebody who can figure out why the corruption happens, and
>   I'll be really happy with a patch that fixes it. In the meantime,
>   "releaseable" very much means that we did _everything_ possible to
>   make sure that people don't screw their disks over.
>
>   You have to realize that stability takes precedence over EVERYTHING.
>
> --
> signature pending
> -

