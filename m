Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSI3U7V>; Mon, 30 Sep 2002 16:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSI3U7V>; Mon, 30 Sep 2002 16:59:21 -0400
Received: from mail.scram.de ([195.226.127.117]:59085 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261312AbSI3U7V>;
	Mon, 30 Sep 2002 16:59:21 -0400
Date: Mon, 30 Sep 2002 23:04:17 +0200
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@seray.bocc.de
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.3.39 LLC on Alpha broken?
In-Reply-To: <Pine.LNX.4.44.0209301000260.1068-100000@alpha.bocc.de>
Message-ID: <Pine.SGI.4.44.0209302302160.1085-100000@seray.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Remaining issues:
>
> - ATY frame buffer not working (black screen with jumpy cursor)
> - ALSA doesn't compile (this seems to be cause by missing include here and
>   there)

 - After shutting down the Alpha with a "reboot" command, the last message
on the console was "Rebooting...". After that... nothing. Not even a
power-off - power-on helped, anymore. I just get 4 beeps from my Alpha
now, indicating an invalid firmware checksum... So 2.5.39 seems to be an
alpha2brick release :-(

--jochen

