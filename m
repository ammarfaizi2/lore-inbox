Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWARTlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWARTlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWARTlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:41:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21510 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030403AbWARTlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:41:50 -0500
Date: Wed, 18 Jan 2006 20:41:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Takashi Iwai <tiwai@suse.de>,
       alsa devel <alsa-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Johannes Stezenbach <js@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Manu Abraham <abraham.manu@gmail.com>
Subject: Re: [RFC] Moving snd-bt87x and btaudio to drivers/media
Message-ID: <20060118194147.GN19398@stusta.de>
References: <1137590968.32449.46.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137590968.32449.46.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 11:29:28AM -0200, Mauro Carvalho Chehab wrote:
>...
> 	This I couldn't found at any Kconfig (but module exists, and also an
> entry at Makefile):
> sound/oss/Makefile:obj-$(CONFIG_SOUND_BT878)    += btaudio.o
>...

The entry is in sound/oss/Kconfig.

> Cheers, 
> Mauro.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

