Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135310AbRDWP3X>; Mon, 23 Apr 2001 11:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135353AbRDWP3D>; Mon, 23 Apr 2001 11:29:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48645 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135310AbRDWP0A>; Mon, 23 Apr 2001 11:26:00 -0400
Subject: Re: Can't compile 2.4.3 with agcc
To: papadako@csd.uoc.gr (mythos)
Date: Mon, 23 Apr 2001 16:27:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0104231611090.15682-100000@iridanos.csd.uch.gr> from "mythos" at Apr 23, 2001 04:13:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14riFe-0008Ev-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Using gcc version pgcc-2.95.3 19991024 (AthlonGCC-0.0.3ex3.1)
> I can't compile 2.4.3.I get the follow message:
> 
> init/main.o: In function `check_fpu':
> init/main.o(.text.init+0x65): undefined reference to
> `__buggy_fxsr_alignment'
> make: *** [vmlinux] Error 1
> 
> Can anyone help me?

Thats either a compiler bug or a funny triggering a compiler bug check

