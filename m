Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267694AbTBLTLu>; Wed, 12 Feb 2003 14:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267701AbTBLTLu>; Wed, 12 Feb 2003 14:11:50 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:12292
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267694AbTBLTLt>; Wed, 12 Feb 2003 14:11:49 -0500
Date: Wed, 12 Feb 2003 14:22:32 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Ducrot Bruno <poup@poupinou.org>
cc: Dave Jones <davej@codemonkey.org.uk>, Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for
 i8042?
In-Reply-To: <20030212184536.GD25632@poup.poupinou.org>
Message-ID: <Pine.LNX.4.44.0302121422200.421-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see, wasn't this better behaviour though?

On Wed, 12 Feb 2003, Ducrot Bruno wrote:

> On Wed, Feb 12, 2003 at 11:14:40AM -0500, Shawn Starr wrote:
> >
> > Right but, why does this *not* show up in 2.4? IRQ 12 is free in 2.4 but
> > not in 2.5 *with* PS/2 mouse enabled?!
>
> Because this interrupt is only requested when /dev/psaux is opened in 2.4.
>
> --
> Ducrot Bruno
> http://www.poupinou.org        Page profaissionelle
> http://toto.tu-me-saoules.com  Haume page
>
>

