Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266639AbRGEHFo>; Thu, 5 Jul 2001 03:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbRGEHFY>; Thu, 5 Jul 2001 03:05:24 -0400
Received: from bcnjfppp.jazztel.es ([212.106.240.79]:17793 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S266637AbRGEHFT>; Thu, 5 Jul 2001 03:05:19 -0400
Date: Thu, 5 Jul 2001 08:37:29 +0200
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: Bill Pringlemeir <bpringle@sympatico.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ronald Bultje <rbultje@ronald.bitfreak.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >128 MB RAM stability problems (again)
Message-ID: <20010705083729.A2414@ragnar-hojland.com>
In-Reply-To: <E15HsKg-0001Pk-00@the-village.bc.nu> <m2sngc3w10.fsf@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <m2sngc3w10.fsf@sympatico.ca>; from bpringle@sympatico.ca on Wed, Jul 04, 2001 at 11:16:43PM -0400
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2001 at 11:16:43PM -0400, Bill Pringlemeir wrote:
> I also have had problems with a machine that had 128Mb + 64 Mb.  I
> discovered the following about 2.4.x.  You _should_ have a swap file
> that is double RAM.  Mixing different SDRAM types is probably a bad
> thing.  So if you upgraded, then that might be problematic.

And here's a counter claim:  At home have 128 + 64, both of different speeds
and brands.  Of course, to run properly you have to force the pc100 to run at
66, but other than that they're happy (96MB swap)

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."
