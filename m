Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbTA2IBy>; Wed, 29 Jan 2003 03:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTA2IBy>; Wed, 29 Jan 2003 03:01:54 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:14853 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265243AbTA2IBw>; Wed, 29 Jan 2003 03:01:52 -0500
Message-Id: <200301290804.h0T84is16077@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
Date: Wed, 29 Jan 2003 10:03:28 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 January 2003 05:44, Marcelo Tosatti wrote:
> So here goes -pre4...
>
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>   o allow people to build M686 without PGE kernels
>   o more vaio apm blacklist entries
>   o mp oops fix
>   o MP message improvements
>   o remove confusing MP report
>   o nmi stack usage
>   o fix linux crash on boot with some boarss
>   o fix up cx86 docs
>   o IPMI driver
>   o enable ipmi config
>   o fix compile of 4.0 DRM
>   o more parisc specific merge bits
>   o parisc mux driver (parisc specific)
>   o disable taskfile I/O
>   o further IDE tape fixes
>   o Skip disabled IDE generic controllers
>   o Add ide software raid driver for Medley IDE raid
>   o add support for Nvidia nForce2 IDE
>   o Allow DMA setup on radeon IGP now we think its fixed
>   o allow selection of SI raid
>   o fix packet padding on 3c501
>   o fix packet padding on the 3c505
>   o more unusual USB storage devices
>   o fix packet padding on the 3c507
>   o fix packet padding on the 3c523
>   o fix packet padding on the 7990
>   o fix packet padding on the 8139too
>   o fix 8390 packet padding
>   o fix packet padding on at1700
>   o fix packet padding on atp
>   o fix de600/20 packet padding
>   o fix ni5010 packet padding
>   o fix ni52 packet padding
>   o fix packet padding on ni65
>   o fix packet padding on axnet_cs
>   o fix padding on sgiseeq
>   o fix sk_g16 padding
>   o fix sun3_82586 padding
>   o fix sun3lance packet padding
>   o further dscc4 updates
>   o document undocumentend field in SCSI headers
>   o fix ad1889 warning - void functions dont return values
>   o more unusual USB storage devices
>   o ; cut the mount hash table down to a sane size, and fix printk
>   o fix casting in pci dma
>   o parisc header update
>   o fix msdos end markers for compatibility with cameras etc

Alan is unbelievable. 8) 
--
vda
