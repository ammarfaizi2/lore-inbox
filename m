Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272533AbRIFTmH>; Thu, 6 Sep 2001 15:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272530AbRIFTl7>; Thu, 6 Sep 2001 15:41:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63505 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272527AbRIFTlo>; Thu, 6 Sep 2001 15:41:44 -0400
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
To: wietse@porcupine.org (Wietse Venema)
Date: Thu, 6 Sep 2001 20:45:19 +0100 (BST)
Cc: kuznet@ms2.inr.ac.ru, matthias.andree@gmx.de (Matthias Andree),
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com, wietse@porcupine.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20010906181826.9CCECBC06C@spike.porcupine.org> from "Wietse Venema" at Sep 06, 2001 02:18:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15f55T-0000Kc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Soldiers are marching down the street. The mother of one of those
> soldiers is ever so proud.  All the other guys are marching out of
> step.  Her son is the only one who does it right.
> 
> That's what it looks like for a person who writes Internet software
> that aims to work on a wide variety of platforms.

I think you have the metaphor wrong. The older API is a bit like the 
cavalry charging into battle at the start of world war one. It may have been
how everyone did it but they guys with the "newfangled, really not how it
should be done, definitely not cricket"  machine guns got the last laugh

Alan
