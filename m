Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281734AbRKULkc>; Wed, 21 Nov 2001 06:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281732AbRKULkW>; Wed, 21 Nov 2001 06:40:22 -0500
Received: from ns.suse.de ([213.95.15.193]:7941 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281724AbRKULkR>;
	Wed, 21 Nov 2001 06:40:17 -0500
Date: Wed, 21 Nov 2001 12:40:16 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
In-Reply-To: <E166VOz-0004kH-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111211239380.4080-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Alan Cox wrote:

> > CPU0 is labelled as an "AMD Athlon(tm) MP Processor 1800+", as expected.
> > CPU1 is instead labelled just "AMD Athlon(tm) Processor".
> Those strings are read directly out of the CPU. Mine for example says
> model name      : AMD-K7(tm) Processor

Better yet.. They're programmed by the BIOS.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

