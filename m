Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbTBLQD5>; Wed, 12 Feb 2003 11:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbTBLQD5>; Wed, 12 Feb 2003 11:03:57 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:2820
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S266983AbTBLQDz>; Wed, 12 Feb 2003 11:03:55 -0500
Date: Wed, 12 Feb 2003 11:14:40 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for
 i8042?
In-Reply-To: <20030212155506.GA13038@codemonkey.org.uk>
Message-ID: <Pine.LNX.4.44.0302121114150.211-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Right but, why does this *not* show up in 2.4? IRQ 12 is free in 2.4 but
not in 2.5 *with* PS/2 mouse enabled?!

Shawn.

On Wed, 12 Feb 2003, Dave Jones wrote:

> On Wed, Feb 12, 2003 at 10:36:16AM -0500, Shawn Starr wrote:
>
>  >   1:         15          XT-PIC  i8042
>
> keyboard.
>
>  >  12:         60          XT-PIC  i8042 <--???
>
> PS2 mouse.
>
> 		Dave
>
> --
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
>
>

