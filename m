Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSIBPwH>; Mon, 2 Sep 2002 11:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318313AbSIBPwG>; Mon, 2 Sep 2002 11:52:06 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19680 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318310AbSIBPwG>; Mon, 2 Sep 2002 11:52:06 -0400
Date: Mon, 2 Sep 2002 17:56:31 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: Samuel Flory <sflory@rackable.com>, Gerd Knorr <kraxel@bytesex.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre4 depmod errors
In-Reply-To: <Pine.LNX.4.44.0209020900580.3234-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.NEB.4.44.0209021754590.147-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2002, Thunder from the hill wrote:

> On Mon, 2 Sep 2002, Adrian Bunk wrote:
> > > /lib/modules/2.4.20-pre4/kernel/drivers/media/video/bttv.o
> > > depmod:         mod_firmware_load_Rsmp_39e3dd23
> >
> > A workaround is to say "M" at "Sound/Sound card support"
>
> Isn't the correct soluion a fresh compile (i.e. from clean sources)?

No, I suspect the problem is the one I describe in [1].

> 			Thunder

cu
Adrian

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=103097532016257&w=2

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


