Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSBMSLd>; Wed, 13 Feb 2002 13:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSBMSLY>; Wed, 13 Feb 2002 13:11:24 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:60489 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S288058AbSBMSLL>; Wed, 13 Feb 2002 13:11:11 -0500
Date: Wed, 13 Feb 2002 19:10:52 +0100 (CET)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: James Simmons <jsimmons@transvirtual.com>
cc: davej@suse.de, Roman Zippel <zippel@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <Pine.LNX.4.10.10202131000090.29350-100000@www.transvirtual.com>
Message-Id: <Pine.LNX.4.44.0202131909000.25623-100000@phobos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, James Simmons wrote:

> diff -urN -X /home/jsimmons/dontdiff linux-2.5.4-dj1/drivers/input/keyboard/Config.help linux/drivers/input/keyboard/Config.help
> --- linux-2.5.4-dj1/drivers/input/keyboard/Config.help	Tue Feb 12 10:48:06 2002
> +++ linux/drivers/input/keyboard/Config.help	Wed Feb 13 10:30:17 2002
> @@ -55,3 +55,12 @@
>    The module will be called maple_keyb.o. If you want to compile it as a
>    module, say M here and read <file:Documentation/modules.txt>.
>
> +CONFIG_KEYBOARD_AMIGA
> +  Say Y here if you are running Linux on a m68k amiga and have a keyboard
> +  attached.
> +
> +  This driver is also available as a module ( = code which can be
> +  inserted in and removed from the running kernel whenever you want).
> +  The module will be called maple_keyb.o. If you want to compile it as a

Is the module name correct?

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

