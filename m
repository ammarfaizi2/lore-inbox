Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267109AbSLKKnB>; Wed, 11 Dec 2002 05:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267110AbSLKKnB>; Wed, 11 Dec 2002 05:43:01 -0500
Received: from CPE-203-51-35-111.nsw.bigpond.net.au ([203.51.35.111]:15343
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S267109AbSLKKnA>; Wed, 11 Dec 2002 05:43:00 -0500
Message-ID: <3DF71882.35A48CE@eyal.emu.id.au>
Date: Wed, 11 Dec 2002 21:50:42 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre1 - unresolved symbols: scx200_gpio.o
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre1/kernel/drivers/char/scx200_gpio.o
depmod:         scx200_gpio_configure
depmod:         scx200_gpio_base
depmod:         scx200_gpio_shadow

Practically everything was built as a module.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
