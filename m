Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbTKXTkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTKXTkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:40:18 -0500
Received: from ghostwheel.llnl.gov ([134.9.11.149]:7839 "EHLO
	ghostwheel.llnl.gov") by vger.kernel.org with ESMTP id S263821AbTKXTkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:40:13 -0500
Date: Mon, 24 Nov 2003 11:39:35 -0800 (PST)
From: Chuck Harding <charding@llnl.gov>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc4
In-Reply-To: <Pine.LNX.4.44.0311241656430.8709-100000@logos.cnet>
Message-ID: <Pine.LNX.4.58.0311241138090.16425@ghostwheel.llnl.gov>
References: <Pine.LNX.4.44.0311241656430.8709-100000@logos.cnet>
Organization: Lawrence Livermore National Laboratory
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The top-level Makefile's EXTRAVERSION gets set to -rc3

On Mon, 24 Nov 2003, Marcelo Tosatti wrote:

>
> Hi,
>
> Here goes -rc4, fixing modular IDE breakage present in 2.4.23 kernels.
>
> Hopefully this will become final.
>
> Enjoy
>
> Summary of changes from v2.4.23-rc3 to v2.4.23-rc4
> ============================================
>
> <arekm:pld-linux.org>:
>   o Fix modular IDE
>
> <lethal:unusual.internal.linux-sh.org>:
>   o sh64: Fixup zImage build for recent ITLB/DTLB changes
>   o sh64: Update defconfig
>   o sh: SH7751 documentation updates
>   o sh/sh64: Clear IRQ_INPROGRESS in setup_irq()
>   o sh: Add SH-DSP support
>
> Richard Curnow:
>   o sh64: Update MAINTAINERS
>
> Willy Tarreau:
>   o fix 2 broken links in bonding documentation
>

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate      ICCD/SDD/ICRMG     Fax: 925-422-8920
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
-- What you enjoy is much more important than what you have. --
