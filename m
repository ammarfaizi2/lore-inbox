Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287051AbSABW3e>; Wed, 2 Jan 2002 17:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287027AbSABW3Q>; Wed, 2 Jan 2002 17:29:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41230 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287040AbSABW2i>; Wed, 2 Jan 2002 17:28:38 -0500
Subject: Re: ISA slot detection on PCI systems?
To: esr@thyrsus.com
Date: Wed, 2 Jan 2002 22:39:27 +0000 (GMT)
Cc: davej@suse.de (Dave Jones), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020102170833.A17655@thyrsus.com> from "Eric S. Raymond" at Jan 02, 2002 05:08:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Lu2i-0005nd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, that's my point.  Saying "just make it suid" is not a good answer, 
> because it ignores the fact that smart sysdamins don't want to run suid
> programs more than absolutely necessary.  Not to mention screwing people
> who follow Linus's good advice and configure/build kernels as non-root.

So you want the lowest possible priviledge level. Because if so thats
setuid app not kernel space. Arguing about the same code in either kernel
space verus setuid app space is garbage.

Alan
