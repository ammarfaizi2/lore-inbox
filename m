Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHBd3>; Wed, 7 Feb 2001 20:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130021AbRBHBdU>; Wed, 7 Feb 2001 20:33:20 -0500
Received: from pille1.addcom.de ([62.96.128.35]:46857 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S129027AbRBHBdE>;
	Wed, 7 Feb 2001 20:33:04 -0500
Date: Thu, 8 Feb 2001 02:34:48 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: BaRT <bart11@dingoblue.net.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 Kernel Crash 
In-Reply-To: <8078.981548195@redhat.com>
Message-ID: <Pine.LNX.4.30.0102080228000.1082-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, David Woodhouse wrote:

> bart11@dingoblue.net.au said:
> >  On one of my linux boxen, that is used as an ISDN router after a 3
> > days of up time I get this: 
> 
> Read http://www.tux.org/lkml/#s4-3
> 
> Particularly the "Don't even bother..." part.

The Call Trace was decoded by klogd, running it through ksymoops won't 
really work. AFAICS the trace makes sense. Since I can't think of any 
relation to the ISDN stack, I asked BaRT to post the trace to l-k, and I 
think it actually provides useful information.

So I'ld hope somebody takes a look into this.

--Kai



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
