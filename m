Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263034AbREaQYP>; Thu, 31 May 2001 12:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263021AbREaQYG>; Thu, 31 May 2001 12:24:06 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:56759 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S262707AbREaQXw>;
	Thu, 31 May 2001 12:23:52 -0400
Date: Thu, 31 May 2001 12:23:12 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
X-X-Sender: <fxian@tiger>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: APIC problem or 3com 3c590 driver problem in smp kernel 2.4.x
In-Reply-To: <Pine.LNX.4.10.10105311110240.759-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0105311217310.785-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am not sure if it's a VIA-based board. It's Dell's SMP board with Intel
820 chipset on it.


-[00]-+-00.0  Intel Corporation 82820 820 (Camino) Chipset Host Bridge
(MCH)
      +-01.0-[01]----00.0  nVidia Corporation Vanta [NV6]
      +-1e.0-[02-03]--+-0a.0-[03]----00.0  Chrysalis-ITS: c0de
      |               \-0c.0  3Com Corporation 3c905C-TX [Fast Etherlink]
      +-1f.0  Intel Corporation 82801AA ISA Bridge (LPC)
      +-1f.1  Intel Corporation 82801AA IDE
      +-1f.2  Intel Corporation 82801AA USB
      +-1f.3  Intel Corporation 82801AA SMBus
      \-1f.5  Intel Corporation 82801AA AC'97 Audio

Alex

On Thu, 31 May 2001, Mark Hahn wrote:

> > I have one pci device in my dell optiplex gx300 dual pIII box. when this
>
> is that a VIA-based board?  if so, there are known problems
> with VIA SMP irq routing.
>

-- 
        Feng Xian
   _o)     .~.      (o_
   /\\     /V\      //\
  _\_V    // \\     V_/_
         /(   )\
          ^^-^^
           ALEX

