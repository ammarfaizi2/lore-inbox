Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270712AbRHZUAj>; Sun, 26 Aug 2001 16:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271514AbRHZUA3>; Sun, 26 Aug 2001 16:00:29 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:58805 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S270712AbRHZUAN>;
	Sun, 26 Aug 2001 16:00:13 -0400
Date: Sun, 26 Aug 2001 22:00:23 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dieter =?utf-8?Q?N=C3=BCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: VCool - cool your Athlon/Duron during idle
Message-ID: <20010826220023.G2994@cerebro.laendle>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dieter =?utf-8?Q?N=C3=BCtzel?= <Dieter.Nuetzel@hamburg.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010826181315Z271401-760+6195@vger.kernel.org> <E15b5W8-0002cC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E15b5W8-0002cC-00@the-village.bc.nu>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 08:24:20PM +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Well my German isnt that good,
   
the page is in english (at least the one you get while clicking on
linux, which is german and english alike, and gthe source code is rather
international ;)

> but it appears to be just another variant
> on CPU idling.

The linux version only fiddles with a single bit in the northbridge that
is claimed to be necessary so the cpu goes into the "real" idle mode. It
also warns that some streaming applications might react to this with frame
drops or similar.

So :/

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
