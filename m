Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbSJTQI1>; Sun, 20 Oct 2002 12:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263181AbSJTQI1>; Sun, 20 Oct 2002 12:08:27 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:13322 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S263178AbSJTQI1>; Sun, 20 Oct 2002 12:08:27 -0400
Date: Sun, 20 Oct 2002 18:08:39 +0200 (CEST)
From: Pawel Kot <pkot@bezsensu.pl>
X-X-Sender: <pkot@urtica.linuxnews.pl>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Dag Brattli <dag@brattli.net>,
       <linux-kernel@vger.kernel.org>, <trivial@rustcorp.com.au>,
       <jt@bougret.hpl.hp.com>
Subject: Re: [2.4 patch] remove obsolete IrDA list from MAINTAINERS
In-Reply-To: <Pine.NEB.4.44.0210201631300.28761-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.33.0210201806170.637-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Adrian Bunk wrote:

> Mail to the list that is in MAINTAINERS bounces and the new mailinglist
> doesn't accept mail from non-subscribers. Since you can find this new
> mailinglist at the IrDA web page it's IMHO the best to simply remove the
> mailing list entry from MAINTAINERS:
>
>
> --- linux-2.4.19/MAINTAINERS.old	2002-10-20 16:30:07.000000000 +0200
> +++ linux-2.4.19/MAINTAINERS	2002-10-20 16:30:16.000000000 +0200
> @@ -828,7 +828,6 @@
>  IRDA SUBSYSTEM
>  P:      Dag Brattli
>  M:      Dag Brattli <dag@brattli.net>
> -L:      linux-irda@pasta.cs.uit.no
>  W:      http://irda.sourceforge.net/
>  S:      Maintained

The new mailing list for Linux-IrDA is: irda-users@lists.sourceforge.net
and the current mainainer is AFAIK Jean Tourrilhes
(jt@bougret.hpl.hp.com).

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

