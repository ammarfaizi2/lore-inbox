Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268402AbRHFNEH>; Mon, 6 Aug 2001 09:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268428AbRHFND7>; Mon, 6 Aug 2001 09:03:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16145 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268377AbRHFNDw>; Mon, 6 Aug 2001 09:03:52 -0400
Subject: Re: [LONGish] Brief analysis of VMAs (was: /proc/<n>/maps getting
To: david_luyer@pacific.net.au (David Luyer)
Date: Mon, 6 Aug 2001 14:05:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <997093086.7179.21.camel@typhaon> from "David Luyer" at Aug 06, 2001 08:18:06 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Tk4u-0000wy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, that's what's happening above.  And it's what's causing the
> splits in the vmas.  So basically evolution-mail is doing exactly what
> your test program was doing, and causing exactly the same thing.
> 
> Seems strange that glibc would do this unless there was some performance
> reason on past kernels to do it?

Are you sure thats not evolution being built with a debugging malloc of
some kind ?

