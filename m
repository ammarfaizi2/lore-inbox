Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268964AbRG0UjQ>; Fri, 27 Jul 2001 16:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268965AbRG0UjG>; Fri, 27 Jul 2001 16:39:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52748 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268964AbRG0Uiu>; Fri, 27 Jul 2001 16:38:50 -0400
Subject: Re: VIA KT133A / athlon / MMX
To: cw@f00f.org (Chris Wedgwood)
Date: Fri, 27 Jul 2001 21:40:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ppeiffer@free.fr (PEIFFER Pierre),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010728083724.A1571@weta.f00f.org> from "Chris Wedgwood" at Jul 28, 2001 08:37:24 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QEP3-0006TF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> On Fri, Jul 27, 2001 at 09:19:21PM +0100, Alan Cox wrote:
>     Its heavily tied to certain motherboards. Some people found a
>     better PSU fixed it, others that altering memory settings
>     helped. And in many cases, taking it back and buying a different
>     vendors board worked.
> 
> Does anyone know *why* stuff breaks? surely VIA do as they have a fix
> for (some, all?) cases of breakage?

At the moment the big problem is I don't have enough reliable info to
see patterns that I can give to VIA for study. VIAs fixes for board problems
are for the fifo problem normally seen with the 686B and SB Live but
sometimes in other cases.

(and it seems also we have a few via + promise weirdnesses on all sorts of
 boards not yet explained)
