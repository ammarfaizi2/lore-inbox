Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbSLEKYa>; Thu, 5 Dec 2002 05:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbSLEKYa>; Thu, 5 Dec 2002 05:24:30 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:29584 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S267264AbSLEKYa>;
	Thu, 5 Dec 2002 05:24:30 -0500
Date: Thu, 5 Dec 2002 11:31:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Erlend Aasland <erlend-a@ux.his.no>
cc: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       LKML <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (m68knommu)
In-Reply-To: <20021203130453.GE2417@johanna5.ux.his.no>
Message-ID: <Pine.GSO.4.21.0212051130190.7346-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2002, Erlend Aasland wrote:
> Remove CONFIG_UDF_RW from defconfig, (it's not used anymore)
> 
> Regards,
> 	Erlend Aasland
> 
> diff -urN linux-2.5.50/arch/m68knommu/defconfig linux-2.5.50-eaa/arch/m68knommu/defconfig
> --- linux-2.5.50/arch/m68knommu/defconfig	Fri Nov 15 12:41:45 2002
> +++ linux-2.5.50-eaa/arch/m68knommu/defconfig	Tue Dec  3 00:48:05 2002
                            ^^^^^^^^^
Sorry, we're not authoritive for m68knommu.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

