Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292878AbSB0TIm>; Wed, 27 Feb 2002 14:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292839AbSB0TIM>; Wed, 27 Feb 2002 14:08:12 -0500
Received: from a213-22-98-46.netcabo.pt ([213.22.98.46]:54473 "EHLO
	aeminium.aeminium.pt") by vger.kernel.org with ESMTP
	id <S292847AbSB0THt>; Wed, 27 Feb 2002 14:07:49 -0500
Date: Wed, 27 Feb 2002 19:07:40 +0000 (WET)
From: Nuno Miguel Fernandes Sucena Almeida <slug@aeminium.org>
To: Sven Koch <haegar@sdinet.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with orinoco_cs and i810_audio
Message-ID: <Pine.LNX.4.21.0202271857350.32513-100000@aeminium.aeminium.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
	i'm having some random hangs in a Satellite Pro 4600, mostly when
the laptop is idle (it seems to be related to apm/pcmcia yenta socket...) 
and i found your message ...
	now, about your problem: try the alsa-modules and you won't regret
it. the i810 drivers that are in stock linux kernel seem to be a bit
braindead ... dunno  if it fixes since altough i can get my wavelan card
to work i don't use it often to connect to the network but instead the
bultin e100 card...oh, and i also use the driver from intel for this
one not the one in the kernel...
	right now i'm using kernel 2.4.17

				()s
					Nuno Sucena
--

