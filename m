Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277861AbRJIRgg>; Tue, 9 Oct 2001 13:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277863AbRJIRg1>; Tue, 9 Oct 2001 13:36:27 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:49413 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S277861AbRJIRgN>;
	Tue, 9 Oct 2001 13:36:13 -0400
Date: Tue, 9 Oct 2001 14:37:23 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: Marco Berizzi <pupilla@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon kernel crash (i686 works)
In-Reply-To: <LAW2-OE3760Ov0Hvk1w000079df@hotmail.com>
Message-ID: <Pine.GSO.4.21.0110091436120.5067-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Oct 2001, Marco Berizzi wrote:

> I also search the mailing list. My mother board is KT7A series v1.3 with
> bios revision 4T (I also try with 3N, same results). K7 at 1333MHz. BIOS
> settings are default (except I have disabled all BIOS/video shadow).
> After flash I also reset CMOS via hardware jumper.
> 
> Is there any solution to this (except compiling kernel for 6x86)?

There is a patch, that changes an unknown bit in the VIA chipset. You can
find it in the archives (search for "Athlon, Try this" or "athlon bug
stomping")

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

