Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270593AbRIFMWY>; Thu, 6 Sep 2001 08:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272464AbRIFMWP>; Thu, 6 Sep 2001 08:22:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9742 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270593AbRIFMVz>; Thu, 6 Sep 2001 08:21:55 -0400
Subject: Re: Solo sound - 2.4.10-pre build fails
To: chris@boojiboy.eorbit.net
Date: Thu, 6 Sep 2001 13:25:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <200109060149.SAA13180@boojiboy.eorbit.net> from "chris@boojiboy.eorbit.net" at Sep 05, 2001 06:49:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15eyDn-000800-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have a laptop with an ESS solo sound chip.
> > I tried compiling 2.4.10-pre4 and
> > the build fails on the sound code.
> 
> 
> The linux kernel 2.4.9-ac9 does build while
> using the esssolo.c code.  
> 
> Somehow this code is broken in 2.4.10-pre

It requires the input device updates. It's up to Vojtech Pavlik when and if
that gets submitted to Linus

