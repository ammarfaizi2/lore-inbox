Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271955AbRIDMJn>; Tue, 4 Sep 2001 08:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271958AbRIDMJe>; Tue, 4 Sep 2001 08:09:34 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:41413 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S271955AbRIDMJX>; Tue, 4 Sep 2001 08:09:23 -0400
Date: Tue, 4 Sep 2001 14:09:06 +0200 (CEST)
From: <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@localhost.localdomain>
To: Thiago Vinhas de Moraes <tvlists@networx.com.br>
cc: <linux-kernel@vger.kernel.org>, <seawolf-list@redhat.com>
Subject: Re: Sound Blaster Live - OSS or Not?
In-Reply-To: <200109032210.f83MA8j15720@jupter.networx.com.br>
Message-ID: <Pine.LNX.4.33.0109041402100.2538-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001, Thiago Vinhas de Moraes wrote:

>
> Hi!
>
> I have a Sound Blaster Live! PCI that works pretty fine for me.
>
> I tried to run loki's Quake 3 Arena for Linux, and after several tries, I
> started to read the README file,

Some persons are reporting problems with Q3 (which mmap's /dev/dsp)
and the latest emu10k1 driver. Others (like me) don't see any problems.
Under investigation.

What Q3 version are you using?
Can you send me a strace of the Q3 startup?

> and it said that Sound Blaster Live does not
> work as OSS.

The driver definetely follows the OSS specification. If a problem was
found at Loki then it would be nice to have a detailed bug report...


Rui Sousa

> I found a reference to www.opensound.com, where they sell OSS
> drivers for Sound Blaster Live for $35.00 !! That's too much money for a
> sound driver! I've downloaded a trial, and it really worked to play Quake.
>
> My question is: If the 2.4.9 kernel has support for Sound Blaster Live, why I
> have to pay for a damn non-GPL driver? Why it does not work to play games on
> linux?
>
>
> Regards,
> Thiago
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

