Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbSLRXlk>; Wed, 18 Dec 2002 18:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267567AbSLRXlk>; Wed, 18 Dec 2002 18:41:40 -0500
Received: from CPE-203-51-35-111.nsw.bigpond.net.au ([203.51.35.111]:38648
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S267550AbSLRXlj>; Wed, 18 Dec 2002 18:41:39 -0500
Message-ID: <3E010992.C96903C@eyal.emu.id.au>
Date: Thu, 19 Dec 2002 10:49:38 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-e1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre2 - unresolved
References: <Pine.LNX.4.50L.0212181721340.18764-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre2/kernel/drivers/char/scx200_gpio.o
depmod:         scx200_gpio_configure
depmod:         scx200_gpio_base
depmod:         scx200_gpio_shadow
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre2/kernel/drivers/i2c/scx200_i2c.o
depmod:         scx200_gpio_configure
depmod:         scx200_gpio_base
depmod:         scx200_gpio_shadow
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre2/kernel/net/irda/irda.o
depmod:         irlmp_lap_tx_queue_full

This is my 'full build' .config where I always select 'm' when offered.
i386.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
