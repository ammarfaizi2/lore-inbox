Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132971AbRDESqS>; Thu, 5 Apr 2001 14:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132975AbRDESqJ>; Thu, 5 Apr 2001 14:46:09 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:34573 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S132971AbRDESpv>; Thu, 5 Apr 2001 14:45:51 -0400
Message-ID: <3ACCBD1C.1363992E@vc.cvut.cz>
Date: Thu, 05 Apr 2001 11:44:44 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: David Balazic <david.balazic@uni-mb.si>
CC: linux-fbdev@vuser.vu.union.edu, linux-kernel@vger.kernel.org,
        linuxconsole-dev@lists.sourceforge.net
Subject: Re: [linux-fbdev] Looking for a card with working TV-out in linux
In-Reply-To: <3ACCADDE.2E72B1BE@uni-mb.si>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic wrote:
> 
> Requirements :
>  - working TV-out ( S-Video or composite-video ), I mean really working
>    and supported in linux, not "it works if the BIOS initializes it and
>    Linux doesn't touch it"

G400 (not G450, TVout on G450 is not supported and maybe never will).
But 
you should preffer XF3.3.x over XF4 (and if you are going to use XF4,
you
must use HAL from Matrox).

>  - video support ( in HW and linux-SW ) is desired ( color space conversion,
>    video overlays and stuff )

G400 hardware can do that, but nobody bothered with implementation.

>  - PCI interface ( I plan later to multihead with another AGP card and also
>    want to keep the price low )

G400. If you do not need opensource, then Matrox HAL driver can
initialize
secondary heads from scratch too.

>  - 3D acceleration welcome ( with XFree86 support ), but not that important

G400.

>  - low price :-)

Sorry. Something else than Matrox ;-)
							Petr Vandrovec
							vandrove@vc.cvut.cz
