Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271627AbRIRRrc>; Tue, 18 Sep 2001 13:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273099AbRIRRrW>; Tue, 18 Sep 2001 13:47:22 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:19053 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S271627AbRIRRrI>; Tue, 18 Sep 2001 13:47:08 -0400
Date: Tue, 18 Sep 2001 12:45:22 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <11433641523.20010918175148@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.3.96.1010918124421.23345A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, VDA wrote:
> Since we don't have any negative feedback on Athlon bug
> stomper, I think patch could be applied to
> arch/i386/kernel/pci-pc.c in mainline kernel.
> Diffed against 4.2.9.
> BTW, there are similar fixup routines in drivers/pci/quirks.c
> Why two .c files for hw related fixes?

One is limited to x86, one is not.

	Jeff




