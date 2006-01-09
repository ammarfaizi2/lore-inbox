Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWAIVlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWAIVlh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWAIVlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:41:20 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:64744 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1750776AbWAIVk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:40:56 -0500
Date: Mon, 9 Jan 2006 22:40:54 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ATI 64-bit fglrx compile patches for 2.6.15-gitX
In-Reply-To: <1136828007.6659.69.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0601092227270.2685@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0601091734300.333@kepler.fjfi.cvut.cz>
 <1136828007.6659.69.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Alan Cox wrote:

> On Llu, 2006-01-09 at 17:47 +0100, Martin Drab wrote:
> > I know this is a little bit OT here, and if you feel irritated by the 
> > binary drivers, just ignore this. 
> 
> Not just offtopic but completely unacceptable in this case.

OK, understood, my appologies.

> There are people on these lists who work on free software R300 reverse
> engineering work. They do not look at and do not want to be exposed in
> any way to proprietary ATI code.

OK (BTW: These were just patches to the open source wrapper of the binary 
drivers, which has to be GPL, since it's a deriver work - at least to my 
knowlege, though IANAL, so there should be no part of a proprietary code.)

> Please don't do this again or if you do post the patches somewhere and
> send a message indicating where they can be found.

OK, sorry, won't do that again.

(I did so only because not long ago there were some postings here from 
people unable to compile it with 2.6.15 kernels, so now that I was forced 
to patch it (for various irrelevant reasons) I thought someone else may 
want to try it as well. But, OK, wouldn't post it again, no problem.)

Martin
