Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTCAKLw>; Sat, 1 Mar 2003 05:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268539AbTCAKLw>; Sat, 1 Mar 2003 05:11:52 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:15710
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266994AbTCAKLw>; Sat, 1 Mar 2003 05:11:52 -0500
Date: Sat, 1 Mar 2003 05:20:06 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Willy Tarreau <willy@w.ods.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, "" <jgarzik@pobox.com>,
       "" <macro@ds2.pg.gda.pl>, "" <marcelo@conectiva.com.br>
Subject: Re: [PATCH][2.4] APIC irq balance
In-Reply-To: <20030301084204.GF5411@alpha.home.local>
Message-ID: <Pine.LNX.4.50.0303010445580.2365-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303010109360.1132-100000@montezuma.mastecende.com>
 <20030301084204.GF5411@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Mar 2003, Willy Tarreau wrote:

> Hi Zwane !
> 
> I've had the same problem on 2.4 since 2.4.21-pre1, but I couldn't find the
> culprit. I've ported your patch to 2.4.21-pre5 and guess what ? it works, as
> shown below. I'd like Maciej to review it quickly (if he has time), so that
> Marcelo could include it in 2.4.21. Patch at the end.

Well that's interesting, i couldn't find a suspicious hunk, but that could 
be because of peripheral noise in the patch.

> Oh, I forgot to say : it's on an Asus A7M266-D, dual XP1800.
> 
> Anyway, congratulations for this finding !

Thanks =) I'll wait on Maciej especially for 2.4

	Zwane
-- 
function.linuxpower.ca
