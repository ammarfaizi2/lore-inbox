Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbRF1Xen>; Thu, 28 Jun 2001 19:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbRF1Xed>; Thu, 28 Jun 2001 19:34:33 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:640 "HELO spiral.extreme.ro")
	by vger.kernel.org with SMTP id <S265051AbRF1XeV> convert rfc822-to-8bit;
	Thu, 28 Jun 2001 19:34:21 -0400
Date: Fri, 29 Jun 2001 02:36:04 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: f5ibh <f5ibh@db0bm.ampr.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5-ac20, make menuconfig problem
In-Reply-To: <200106282022.WAA10248@db0bm.ampr.org>
Message-ID: <Pine.LNX.4.33L2.0106290235440.23538-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, f5ibh wrote:

> make[4]: Entre dans le répertoire
> `/usr/src/kernel-sources-2.4.5-ac20/drivers/pnp'
> gcc -D__KERNEL__ -I/usr/src/kernel-sources-2.4.5-ac20/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
> -DEXPORT_SYMTAB -c pnp_bios.c
> pnp_bios.c:252: warning: static declaration for `pnp_bios_dock_station_info'
> follows non-static
> pnp_bios.c:432: warning: no semicolon at end of struct or union

gcc -v?


