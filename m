Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSFVPKu>; Sat, 22 Jun 2002 11:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSFVPKt>; Sat, 22 Jun 2002 11:10:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13838 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314284AbSFVPKs>; Sat, 22 Jun 2002 11:10:48 -0400
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
To: landley@trommello.org (Rob Landley)
Date: Sat, 22 Jun 2002 16:31:36 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), lm@bitmover.com (Larry McVoy),
       ebiederm@xmission.com (Eric W. Biederman),
       torvalds@transmeta.com (Linus Torvalds), cort@fsmlabs.com (Cort Dougan),
       bcrl@redhat.com (Benjamin LaHaise),
       rusty@rustcorp.com.au (Rusty Russell), rml@tech9.net (Robert Love),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <200206220132.g5M1WjI160594@pimout3-int.prodigy.net> from "Rob Landley" at Jun 21, 2002 03:34:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17LmrQ-0002vp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A microkernel design was actually made to work once, with good performance.  
> It was about fifteen years ago, in the amiga.  Know how they pulled it off?  
> Commodore used a mutant ultra-cheap 68030 that had -NO- memory management 
> unit.

Vanilla 68000 actually. And it never worked well - the UI folks had
to use a library not threads. The fs performance sucked
