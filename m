Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131301AbRAaAhV>; Tue, 30 Jan 2001 19:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131680AbRAaAhL>; Tue, 30 Jan 2001 19:37:11 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:26354 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S131301AbRAaAgx>; Tue, 30 Jan 2001 19:36:53 -0500
Date: Tue, 30 Jan 2001 18:36:51 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200101310008.f0V08Wv23250@localhost.localdomain>
Subject: Re: Request: increase in PCI bus limit
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <FLRPM.A.TsC.j41d6@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Christopher Neufeld <neufeld@linuxcare.com> on Tue, 30
Jan 2001 16:08:32 -0800


> Would it be possible to bump it up to 128, or even
> 256, in later 2.4.* kernel releases?  That would allow this customer to
> work with an unpatched kernel, at the cost of an additional 3.5 kB of
> variables in the kernel.

I don't think that's going to happen.  If we did this for your obscure system,
then we'd have to do it for every obscure system, and before you know it, the
kernel is 200KB larger.

Besides, why is your client afraid of patched kernels?  It sounds like a very
odd request from someone with a linuxcare.com email address.  I would think that
you'd WANT to provide patched kernels so that the customer can keep paying you
(until they learn how to use a text editor, at which point they can patch the
kernel themselves!!!)


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
