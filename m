Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310740AbSCMQWw>; Wed, 13 Mar 2002 11:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310742AbSCMQWd>; Wed, 13 Mar 2002 11:22:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15635 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310740AbSCMQWX>; Wed, 13 Mar 2002 11:22:23 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 13 Mar 2002 16:37:54 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20020313184028.7fdb8541.rusty@rustcorp.com.au> from "Rusty Russell" at Mar 13, 2002 06:40:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lBlC-0006nQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And no, it's not worth discontinuing i386 support.  It just isn't
> > painful enough to maintain. 
> 
> How about just dropping 386 + SMP support?

We dont support SMP 386 boxes anyway. Nothing to drop. We've never supported
anything earlier than 486 SMP like the early MP1.1 compliant IBM boards, 
(and briefly the compaq non MP 1.1 compliant stuff  (Thomas Radke - the
forgotten man in the creation of SMP Linux - did 2/4 way compaq stuff)
