Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271670AbRHUN5Q>; Tue, 21 Aug 2001 09:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271674AbRHUN45>; Tue, 21 Aug 2001 09:56:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31505 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271670AbRHUN4l>; Tue, 21 Aug 2001 09:56:41 -0400
Subject: Re: i810 audio doesn't work with 2.4.9
To: pavenis@latnet.lv (Andris Pavenis)
Date: Tue, 21 Aug 2001 14:59:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Andris Pavenis" at Aug 21, 2001 11:16:48 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZC3v-0007tI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i810 audio didn't work for me with kernel 2.4.9 (artsd from KDE goes into infinite loop, no sound). 
> 
> Reverting to kernel 2.4.7 or replacing in 2.4.9 drivers/sound/ac97_codec.c, drivers/sound/i810_audio.c, 
> include/linux/ac97_codec.h from 2.4.8-ac8 fixed the problem for me

Thats good to know - the 2.4.8-ac8 one is scheduled to go to Linus

