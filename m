Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265861AbRF2L2T>; Fri, 29 Jun 2001 07:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265862AbRF2L2J>; Fri, 29 Jun 2001 07:28:09 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:46723 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S265861AbRF2L2A>; Fri, 29 Jun 2001 07:28:00 -0400
Posted-Date: Fri, 29 Jun 2001 13:24:06 +0100 (WEST)
Date: Fri, 29 Jun 2001 13:27:55 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200106291127.NAA17693@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac20, make menuconfig problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Thu, 28 Jun 2001, f5ibh wrote:

>> make[4]: Entre dans le répertoire
>> `/usr/src/kernel-sources-2.4.5-ac20/drivers/pnp'
>> gcc -D__KERNEL__ -I/usr/src/kernel-sources-2.4.5-ac20/include -Wall
>> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
>> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
>> -DEXPORT_SYMTAB -c pnp_bios.c
>> pnp_bios.c:252: warning: static declaration for `pnp_bios_dock_station_info'
>> follows non-static
>> pnp_bios.c:432: warning: no semicolon at end of struct or union

>gcc -v?

Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20010319 (Debian prerelease)

----
Regards
		Jean-Luc
