Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136368AbRD2Upn>; Sun, 29 Apr 2001 16:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136367AbRD2Uph>; Sun, 29 Apr 2001 16:45:37 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:14051 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S136354AbRD2UpZ>;
	Sun, 29 Apr 2001 16:45:25 -0400
Message-Id: <m14ty4B-000OWbC@amadeus.home.nl>
Date: Sun, 29 Apr 2001 21:45:15 +0100 (BST)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com> <3AEBF782.1911EDD2@mandrakesoft.com> <15083.64180.314190.500961@pizda.ninka.net> <20010429153229.L679@nightmaster.csn.tu-chemnitz.de> <200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca> <20010429221159.U706@nightmaster.csn.tu-chemnitz.de>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010429221159.U706@nightmaster.csn.tu-chemnitz.de> you wrote:
> Yes, but we currently have more than 10K cycles for doing
> memset of a page.

make that 3800 or so..... (700 Mhz AMD Duron)

