Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbTCRXIl>; Tue, 18 Mar 2003 18:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbTCRXIV>; Tue, 18 Mar 2003 18:08:21 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:15289 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262617AbTCRXHv>;
	Tue, 18 Mar 2003 18:07:51 -0500
Date: Wed, 19 Mar 2003 10:18:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys32_ioctl -> compact_sys_ioctl patches
Message-Id: <20030319101829.57266c3b.sfr@canb.auug.org.au>
In-Reply-To: <20030318202524.GA132@elf.ucw.cz>
References: <20030318202524.GA132@elf.ucw.cz>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003 21:25:24 +0100 Pavel Machek <pavel@ucw.cz> wrote:
>
> I tried posting ioctl32 patches to Linus several times, and got
> nothing back.

Linus is busy I guess.  I have several patches pending as well.

> Patches were tested at x86-64 and sparc64, and general attitude seems
> to be "anything that gets code out of ioctl32.c is welcome".

Yeah, I get that as well :-)

> Do you think you could try to push them through?

I'll do my best.

Thanks for all the work.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
