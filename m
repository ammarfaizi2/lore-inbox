Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSHCUvX>; Sat, 3 Aug 2002 16:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317750AbSHCUvX>; Sat, 3 Aug 2002 16:51:23 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:31388 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317743AbSHCUvX>;
	Sat, 3 Aug 2002 16:51:23 -0400
Date: Sat, 3 Aug 2002 22:54:53 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200208032054.WAA25022@harpo.it.uu.se>
To: nico-mutt@schottelius.org
Subject: Re: 2.5.29 / 2.5.31 floppy/apm support
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2002 07:07:52 +0200, Nico Schottelius wrote:
>I am currently trying to find a kernel, which supports wifi, floppy,apm.
>As you can see in my header I downgraded to 2.5.24 right now, but floppy
>is broken herein, too.
>Now I am trying 2.5.20, perhaps this works ...

For 100% working floppy you'd need to downgrade to 2.5.12 or earlier.

>I am still hoping that in 2.5.31/32 floppy and apm will work again.

Floppy working soon? Only if a miracle happens.

I'd recommend that you backport this "wifi" thing (whatever it is)
to 2.4.19 and run that instead of 2.5.

/Mikael
