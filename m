Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287439AbSBDTvw>; Mon, 4 Feb 2002 14:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbSBDTvm>; Mon, 4 Feb 2002 14:51:42 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:65514 "HELO
	dardhal") by vger.kernel.org with SMTP id <S287439AbSBDTv1>;
	Mon, 4 Feb 2002 14:51:27 -0500
Date: Mon, 4 Feb 2002 20:51:19 +0100
From: Jose Luis Domingo Lopez <jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Cc: Fabrice Eudes <fabrice.eudes@free.fr>
Subject: Re: Can't boot 2.4.17 or 2.5.1 kernel
Message-ID: <20020204195119.GB2386@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Fabrice Eudes <fabrice.eudes@free.fr>
In-Reply-To: <20020204113949.A1695@corwin.ambre.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020204113949.A1695@corwin.ambre.fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 04 February 2002, at 11:39:49 +0100,
Fabrice Eudes wrote:

> Hello,
> [...]
> Uncompressing Linux... Ok, booting the kernel.
> [end grub output]
> and the machine is stucked there...
> It seems to me that grub loads the kernel ok but when grub gives it the
> hand, the problem occurs...
>
I have been suffering similar problems for some time, with a box quite
older than yours, and with different kernels which wouldn't boot.

For example, old Debian Potato 2.2.17 always booted fine, but 2.2.18
sometimes failed at the same place as in your machine. 2.2.19 was a real
pain to make it boot, as well as some 2.4.x kernels. Sometimes the
machine hangs, sometimes it reboots. From some specific 2.4.x kernel
version (exact version number is lost somewhere in my mind, but maybe
2.4.13+, maybe earlier) any kernel booted fine.

One day I tried again to boot those "problematic" kernels from the same
PC, now upgraded to Woody, and the problems appeared in the same places.
One thing that I noticed is that Alan's 2.4.x-acY kernels had no
problems booting where plain 2.4.x kernels failed.

Hope thos helps.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

