Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264051AbSIVLhJ>; Sun, 22 Sep 2002 07:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264055AbSIVLhJ>; Sun, 22 Sep 2002 07:37:09 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:65172 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S264051AbSIVLhJ>;
	Sun, 22 Sep 2002 07:37:09 -0400
Date: Sun, 22 Sep 2002 13:42:07 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209221142.NAA10111@harpo.it.uu.se>
To: bazooka@vekoll.vein.hu, linux-kernel@vger.kernel.org
Subject: Re: ESR bad value...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2002 17:43:48 +0200, Banai Zoltan wrote:
>I have a problem with kernels >2.4.17,
>booting them i got error message
>ESR bad value enabling vector 00000004
>Using 2.2.x and <=2.4.17 there is no probelm
>
>The hardware is an Intergraph TDZ-310
>PPro-200Mhz, 450KX/GX chipset.
>
>My config with 2.4.19-ac4 (is similar to configs
>use with 2.4.9 with JFS) is attached.

There is no such message in a standard 2.4.19 kernel.
Please post the _exact_ message(s). Also, are you sure it's
an error and not just informational? Does the box work?

/Mikael
