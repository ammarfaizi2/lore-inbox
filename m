Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267567AbSLSBOE>; Wed, 18 Dec 2002 20:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbSLSBOE>; Wed, 18 Dec 2002 20:14:04 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:40412 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267567AbSLSBOD>;
	Wed, 18 Dec 2002 20:14:03 -0500
Date: Wed, 18 Dec 2002 17:21:28 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re : Linux 2.4.21-pre2 - unresolved
Message-ID: <20021219012127.GA1281@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky wrote :
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.21-pre2/kernel/net/irda/irda.o
> depmod:         irlmp_lap_tx_queue_full

	It looks like Marcelo did drop some of my IrDA patches (the
LAP scheduler to be exact). You can find the necessary patch on my web
page.
	I'll compile 21-pre2 and I'll deal with that with Marcelo.

	Have fun...

	Jean
