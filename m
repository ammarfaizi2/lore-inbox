Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbTANMKp>; Tue, 14 Jan 2003 07:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbTANMKo>; Tue, 14 Jan 2003 07:10:44 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:6615 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262395AbTANMKo>;
	Tue, 14 Jan 2003 07:10:44 -0500
Date: Tue, 14 Jan 2003 13:18:39 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Vadlapudi Madhu <Vadlapudi.Madhu@cse.iitkgp.dhs.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Vadlapudi.Madhu - 01cs6020" <vmadhu@cse.iitkgp.dhs.org>
Subject: Re: Is linux kernel is available for any AMD processors?
In-Reply-To: <20030113140855.GH9031@codemonkey.org.uk>
Message-ID: <Pine.GSO.4.21.0301141317494.27333-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Dave Jones wrote:
> On Mon, Jan 13, 2003 at 07:26:43PM +0530, Vadlapudi Madhu wrote:
>  > Just i want to know, whether linux kernel is available any of the AMD's
>  > processors. If yes, please direct towards a web page where i can get some
>  > more information.
> 
> All of AMD's CPUs should work fine with the standard kernel.
> They'll boot a generic 'i386' kernel, or you can compile
> specific kernels optimised for Athlon/Duron.

Don't know which AMD CPUs the original poster intended, but i386 kernels don't
boot on Am29000. Yes, AMD produced non-i386 compatible CPUs as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

