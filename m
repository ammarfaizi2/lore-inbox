Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVHBNyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVHBNyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 09:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVHBNyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 09:54:20 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:29329 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261524AbVHBNyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 09:54:11 -0400
Date: Tue, 2 Aug 2005 09:54:11 -0400
To: Richard Hubbell <richard.hubbell@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Where's the list of needed hardware for donating?
Message-ID: <20050802135411.GF31019@csclub.uwaterloo.ca>
References: <c25b253205072710481c157e4c@mail.gmail.com> <20050728230047.GA4385@elf.ucw.cz> <c25b2532050728190311d6c339@mail.gmail.com> <20050730092904.GC2013@elf.ucw.cz> <c25b25320507311506258736b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25b25320507311506258736b7@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 10:06:38PM +0000, Richard Hubbell wrote:
> Ok, here's the list:
> 
> Adaptec AHA-1510A
> (ISA, centronix-style external connector with terminator, one internal
> ribbon cable,
> I probably have some centronix-style external cables around too, this
> card doesn't have it's own boot ROM)
> 
> Gravis UltraSound a.k.a. GUS
> (ISA, fully loaded with memory, 1megabyte (I think))

Hasn't that been fully supported for years in ALSA?  I remember the guy
that started ALSA had written an amazing driver for the GUS before
starting ALSA.

> Pertec MyTape 800
> (I think this is a QIC tape drive that connects via the floppy interface)

I thought QIC floppy connected tape drives were supported as well.

> TEAC 1.44  3.5 inch Floppy FDR
> (FD-235HF)

Standard 3.5" floppy drive?

> Rocket Port 8-port serial board
> (ISA, 8 - RJ11 jacks, made by Comtrol, brand-new in-box)

I know nothing about the support of the rest of the hardware.

Len Sorensen
