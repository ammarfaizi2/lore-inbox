Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287084AbRL2CYT>; Fri, 28 Dec 2001 21:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287090AbRL2CYJ>; Fri, 28 Dec 2001 21:24:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21764 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287084AbRL2CXu>; Fri, 28 Dec 2001 21:23:50 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: zImage not supported for 2.2.20?
Date: 28 Dec 2001 18:23:45 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a0j9fh$tjn$1@cesium.transmeta.com>
In-Reply-To: <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1> <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <20011228163250.A31791@elektroni.ee.tut.fi> <20011228211348.A8720@upset.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011228211348.A8720@upset.pdb.fsc.net>
By author:    Wolfgang Erig <Wolfgang.Erig@fujitsu-siemens.com>
In newsgroup: linux.dev.kernel
> 
> Loading linux 2.2.20.......
> Uncompressing Linux...
> 
> Out of memory
> 
>  -- System halted
> 
> Siemens/Nixdorf Mobile 710
> Pentium MMX 166MHz, 128MB
> 
> Kernel 2.2.20 generated from perfectly running 2.2.19 with
> make oldconfig; make dep; make zImage; ...
> 
> 2.4.16 does not work too:
> Loading linux 2.4.16........
> 
> [ black screen and than back in BIOS-boot ]
> 

Chipset info?  BIOS info?

Also, is there any connection between this box and the Toshiba Tecra
710 (since they have similar type numbers?)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
