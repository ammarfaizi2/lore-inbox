Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273943AbRIRVjV>; Tue, 18 Sep 2001 17:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273944AbRIRVjL>; Tue, 18 Sep 2001 17:39:11 -0400
Received: from skiathos.physics.auth.gr ([155.207.123.3]:6810 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S273943AbRIRVi7>; Tue, 18 Sep 2001 17:38:59 -0400
Date: Wed, 19 Sep 2001 00:39:07 +0300 (EET DST)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <11433641523.20010918175148@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.GSO.4.21.0109190034030.7240-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please consider making it a configurable option. 

My Asus A7V133 runs perfectly well with 55.7=1 and so does at least
another mobo brand that was reported here. If it can work out of the box,
leave it that way. Since this register is undocumented the patch below is
a hack. Sure it works on people hitting the problem but it is still a
hack. As such I don't want to use it if I don't have to.

-K.


On Tue, 18 Sep 2001, VDA wrote:

> Hi Linus, Alan,
> 
> Since we don't have any negative feedback on Athlon bug
> stomper, I think patch could be applied to
> arch/i386/kernel/pci-pc.c in mainline kernel.
> Diffed against 4.2.9.
[patch snipped]


