Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbSI3XKR>; Mon, 30 Sep 2002 19:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbSI3XKR>; Mon, 30 Sep 2002 19:10:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:44751 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261384AbSI3XKR>; Mon, 30 Sep 2002 19:10:17 -0400
Date: Mon, 30 Sep 2002 18:23:21 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: jt@hpl.hp.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <rmk@arm.linux.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.20-pre8] irtty MODEM_BITS additional fix
In-Reply-To: <20020926023950.GA17708@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0209301822500.32532-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Sep 2002, Jean Tourrilhes wrote:

> 	Hi Marcelo,
>
> 	Alan did fix the compile of the irtty driver for i386 in
> pre8. Unfortunately, there is still many platforms which doesn't
> compile, including some that I know where IrDA is heavily used (PPC,
> ARM).
> 	This patch make sure the code works on all platforms. It's
> 2.4.X, so I guess the code *must* work.
>
> 	Regards,

I'll remove that once we have all arch's OK.

Thanks

