Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318324AbSIBQss>; Mon, 2 Sep 2002 12:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318326AbSIBQsr>; Mon, 2 Sep 2002 12:48:47 -0400
Received: from pD9E237CF.dip.t-dialin.net ([217.226.55.207]:30952 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318324AbSIBQsr>; Mon, 2 Sep 2002 12:48:47 -0400
Date: Mon, 2 Sep 2002 10:53:14 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Adrian Bunk <bunk@fs.tum.de>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Samuel Flory <sflory@rackable.com>, Gerd Knorr <kraxel@bytesex.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre4 depmod errors
In-Reply-To: <Pine.NEB.4.44.0209021754590.147-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0209021052100.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Sep 2002, Adrian Bunk wrote:
> > On Mon, 2 Sep 2002, Adrian Bunk wrote:
> > > > /lib/modules/2.4.20-pre4/kernel/drivers/media/video/bttv.o
> > > > depmod:         mod_firmware_load_Rsmp_39e3dd23
> >
> > Isn't the correct soluion a fresh compile (i.e. from clean sources)?
> 
> No, I suspect the problem is the one I describe in [1].

The symbol type looks horribly different:
above: symbol w/version
below: symbol w/o version

> [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=103097532016257&w=2


			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

