Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263521AbRFNSNr>; Thu, 14 Jun 2001 14:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263606AbRFNSNh>; Thu, 14 Jun 2001 14:13:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47373 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263521AbRFNSNa>; Thu, 14 Jun 2001 14:13:30 -0400
Subject: Re: unregistered changes to the user<->kernel API
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 14 Jun 2001 19:11:27 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds), mingo@elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org, rth@redhat.com (Richard Henderson)
In-Reply-To: <20010614200328.A2115@athlon.random> from "Andrea Arcangeli" at Jun 14, 2001 08:03:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15AbaZ-00054p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Tangent:  Why is this webserver-specific crap in kernel_stat anyway?  It
> > Even when merging Tux, I would hope Linus would not apply this
> > particular change.
> 
> Indeed, I also said this in my first email :)

I dont see why Tux should be merged. If we have people achieving the same
performance in user space with the core facilities tux added to the kernel
like the better irq/sendfile stuff why bother merging tux ?
