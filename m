Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266024AbRF1QiV>; Thu, 28 Jun 2001 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266026AbRF1QiM>; Thu, 28 Jun 2001 12:38:12 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:39181 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S266024AbRF1QiD>; Thu, 28 Jun 2001 12:38:03 -0400
Message-ID: <3B3B5D62.2B84245C@delusion.de>
Date: Thu, 28 Jun 2001 18:37:54 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac20
In-Reply-To: <20010628164212.A27412@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> This is the initial merge with 2.4.6pre - treat this one with care, it may
> not be the most reliable 2.4.5ac release ever made

make[3]: Entering directory `/usr/src/linux-2.4.5-ac/drivers/pnp'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.5-ac/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -DEXPORT_SYMTAB -c pnp_bios.c
pnp_bios.c:252: warning: static declaration for `pnp_bios_dock_station_info' follows non-static
pnp_bios.c:432: warning: no semicolon at end of struct or union
pnp_bios.c:432: parse error before `u16'
pnp_bios.c: In function `pnp_dock_thread':
pnp_bios.c:442: warning: function declaration isn't a prototype
pnp_bios.c:442: warning: extern declaration of `daemonize' doesn't match global one
pnp_bios.c:445: parse error before `struct'
pnp_bios.c:445: warning: unused variable `err'
pnp_bios.c: At top level:
pnp_bios.c:435: storage size of `dock' isn't known
pnp_bios.c:435: warning: `dock' defined but not used
pnp_bios.c:440: warning: `pnp_dock_thread' defined but not used
{standard input}: Assembler messages:
{standard input}:63: Warning: indirect lcall without `*'
{standard input}:143: Warning: indirect lcall without `*'
{standard input}:201: Warning: indirect lcall without `*'
{standard input}:240: Warning: indirect lcall without `*'
