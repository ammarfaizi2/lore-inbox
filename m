Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269922AbRHEFiq>; Sun, 5 Aug 2001 01:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269923AbRHEFih>; Sun, 5 Aug 2001 01:38:37 -0400
Received: from quattro.sventech.com ([205.252.248.110]:50181 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S269922AbRHEFia>; Sun, 5 Aug 2001 01:38:30 -0400
Date: Sun, 5 Aug 2001 01:38:37 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org
Subject: Re: SMP Support for AMD Athlon MP motherboards
Message-ID: <20010805013835.T3126@sventech.com>
In-Reply-To: <002b01c11d62$73e65540$8405000a@slurv> <20010805173024.C20716@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010805173024.C20716@weta.f00f.org>; from cw@f00f.org on Sun, Aug 05, 2001 at 05:30:24PM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001, Chris Wedgwood <cw@f00f.org> wrote:
> On Sun, Aug 05, 2001 at 05:55:22AM +0200, Andre Tomt wrote:
> 
>     I recently got my hands on a unreleased evaluation AthlonMP
>                                  ^^^^^^^^^^^^^^^^^^^^^
>     motherboard with two 1.1Ghz Athlon CPU's. First thing I tried was
>     of course Linux. I ran into some problems, however.
> 
> Linux does support this, and people are using it --- with no
> major problems.
> 
> Maybe your board is busted?  If you think that not the case, please
> try 2.4.7+ and report specifically what the problems are in more
> detail if you can (ie. supply dmesg from boot, etc).

All of the 2.4 kernels that worked on PIII systems worked on my Dual
Athlon.

> Anyhow, you 2.2.x you need something very recent, maybe 2.2.20+ I
> think.

Only for SMP. Atleast all of the later 2.2 kernels worked fine with the
Tyan MP Athlon board with the UP kernel.

To get SMP working you need to apply the patches I created. They just
got to Alan and I don't think they're in 2.2.20pre yet, but it sounds
like they'll be in there soon.

Anyway, it sounds like a hardware problem.

JE

