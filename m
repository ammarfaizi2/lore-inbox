Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263289AbSJJHXa>; Thu, 10 Oct 2002 03:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSJJHX3>; Thu, 10 Oct 2002 03:23:29 -0400
Received: from [195.39.17.254] ([195.39.17.254]:2052 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263289AbSJJHWP>;
	Thu, 10 Oct 2002 03:22:15 -0400
Message-Id: <200210100725.JAA00149@bug.ucw.cz>
From: Pavel Machek <pavel@ucw.cz>
To: <sfr@canb.auug.org.au>
Cc: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
       Jeff Dike <jdike@karaya.com>
Date: Thu, 10 Oct 2002 09:23:40 +0200
Subject: Re: [PATCH] make do_signal static on i386
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am not sure whether we need the FASTCALL() or whether the change
> in the comment in asm-um/signal.h makes sense.  (Does UML work on
> x86_64, yet?)
>

I dont think it does... 
