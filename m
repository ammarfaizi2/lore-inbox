Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274062AbRISNlz>; Wed, 19 Sep 2001 09:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274061AbRISNlp>; Wed, 19 Sep 2001 09:41:45 -0400
Received: from skiathos.physics.auth.gr ([155.207.123.3]:50345 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S274053AbRISNl3>; Wed, 19 Sep 2001 09:41:29 -0400
Date: Wed, 19 Sep 2001 16:41:08 +0300 (EET DST)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <1022874923.20010919160805@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.GSO.4.21.0109191619570.22381-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am just opposing to be forced to use a fix when a fix isn't really
needed on my setup.


On Wed, 19 Sep 2001, VDA wrote:

> Look into pci-pc.c amd quirks.c: do you want to make all those
> config options too?

I will, and if I find something done not needed I might complain again.

> Also, do you want people to spend days finding out why their
> once stable system with their brand new, faster processor
> started to oops, finally giving up and posting about this to lkml?

I dont suppose it will take more than an hour for somebody to notice that
under the "Optimized for K7" option there is another called "Enable 55.7=0
fix for K7 that oops all over the place"

Please calm down. I never suggested your fix is wrong. It was a long
awaited one indeed. I only suggested that it be applied wherever it needs
to be, not blindly whenever a KT133/A setup is seen.

If you don't agree with my view, just say why, don't go arround mocking me
about it.

-K.


