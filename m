Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSGPLyf>; Tue, 16 Jul 2002 07:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSGPLye>; Tue, 16 Jul 2002 07:54:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54144 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315870AbSGPLyd>; Tue, 16 Jul 2002 07:54:33 -0400
Date: Tue, 16 Jul 2002 07:58:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: SCoTT SMeDLeY <ss@aaoepp.aao.gov.au>
cc: linux-kernel@vger.kernel.org, ss@aao.gov.au
Subject: Re: Tyan s2466 stability
In-Reply-To: <20020716212336.A393@aaopcss.aao.gov.au>
Message-ID: <Pine.LNX.3.95.1020716073755.7363A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, SCoTT SMeDLeY wrote:

> Hi all,
> 
> I'm considering investing in a dual-AMD system using Tyan's s2466
> motherboard. I'm interested in hearing how others have found the
> stability of this board using recent 2.4.x kernels.
> 
> I've scanned the archives & there doesn't appear to be any reports
> on problems with this board, so I guess I'm hoping to hear some
> positive reports ...
> 
> I'm also interested in hearing reports about how the board performs
> with with non-ECC (non-registered) RAM as the board has been
> documented to work with such an arrangement. I'm happy to fork
> out for ECC RAM, but is it worth it?
> 
> Please reply to: ss@aao.gov.au
> 

We got one here about two weeks ago. It had 2 AMD processors plus
2 'sticks' of RAM (Don't know how much). It was originally tested
on an IDE drive booting Windows/2000. It worked, but a CPU had to
be removed because W$ trashes drives when using two CPUs.

I got to play with it for an hour. I put one of my BusLogic SCSI
controllers in one of the 33MHz slots and booted Linux off an existing
SCSI drive. It did not run long before crashing (I booted a SMP
kernel). Again, I booted it with only one CPU and it did not crash.

I don't know if it's an AMD problem or a Motherboard problem. Perhaps
AMD processors don't work well in SMP, I've always used Intel with
success.

Nevertheless, I was entirely unimpressed with this "MPX" board. It
didn't have built-in SCSI like older Tyan boards that I currently use
and it didn't work very well. My AGP graphics card (G-Force) didn't
work either (in graphics) although I'm told that 'newer' ones do.

It is also kinda expensive (over US$200).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

