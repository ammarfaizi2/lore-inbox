Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269962AbRHEOCZ>; Sun, 5 Aug 2001 10:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269960AbRHEOCF>; Sun, 5 Aug 2001 10:02:05 -0400
Received: from [144.137.82.31] ([144.137.82.31]:23054 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S269959AbRHEOB6>;
	Sun, 5 Aug 2001 10:01:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /proc/ksyms change for IA64 
In-Reply-To: Your message of "Sun, 05 Aug 2001 17:16:33 +1000."
             <13470.996995793@ocs3.ocs-net> 
Date: Mon, 06 Aug 2001 00:02:51 +1000
Message-Id: <E15TOUV-00012J-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <13470.996995793@ocs3.ocs-net> you write:
> >Eewwww....
> >
> >	How about just adding /proc/ksyms-ia64 with the code pointers
> >which contains the ia64 code addresses required by ksymoops and
> >debuggers.  These are, after all, less vital than insmod.
> 
> That requires changes to every kernel debugger, oops decoder etc.  I
> don't control all of Linux debugging yet ;).  It is also more work
> because it requires kernel changes as well as lots of user space.

For ia64 only.  IMHO, that's a better line to draw.

Rusty.
--
Premature optmztion is rt of all evl. --DK
