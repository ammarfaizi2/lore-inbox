Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316833AbSGHKCl>; Mon, 8 Jul 2002 06:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSGHKCk>; Mon, 8 Jul 2002 06:02:40 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:4617 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316833AbSGHKCj>; Mon, 8 Jul 2002 06:02:39 -0400
Date: Mon, 8 Jul 2002 12:05:04 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Patrick Clohessy <pat@cs.curtin.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: spurious 8259A interrupt: IRQ7
Message-ID: <20020708100504.GM7554@louise.pinerecords.com>
References: <3D2957A9.6D90A916@cs.curtin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2957A9.6D90A916@cs.curtin.edu.au>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 33 days, 9:20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have read through quite a few mailing lists and other sources but
> can't find an adequate solution. One solution I found was to turn off
> Local APIC support and IO-APIC support in the kernel, which I tried and
> it worked, but I'd rather not do this. I realise the error isn't of a
> huge concern but it's still annoying having it appear everytime the
> machine boots up.

Your fix is to just realize that this is a mere warning -- Nothing's
wrong with your setup.

If you dig out a thread that came through here abt. two months ago,
you'll find a comprehensive explanation of what the message means.

T.
