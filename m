Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbRFKC1e>; Sun, 10 Jun 2001 22:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263353AbRFKC1Z>; Sun, 10 Jun 2001 22:27:25 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:37605 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S263344AbRFKC1K>; Sun, 10 Jun 2001 22:27:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.4.5-ac12: 3c590.c: Warning about 'nopnp' parameter
Date: Mon, 11 Jun 2001 04:35:42 +0200
X-Mailer: KMail [version 1.2.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010611022716Z263344-17720+2633@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taken from boot.msg:

Setting up network device eth1
insmod: Warning: /lib/modules/2.4.5-ac12/kernel/drivers/net/3c509.o symbol 
for parameter nopnp not found
 done

I've tried with and without ISA PNP support.

Any hints?

Thanks,
	Dieter
