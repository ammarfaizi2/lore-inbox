Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312136AbSDNLUJ>; Sun, 14 Apr 2002 07:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312141AbSDNLUJ>; Sun, 14 Apr 2002 07:20:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:36584 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312136AbSDNLUI>; Sun, 14 Apr 2002 07:20:08 -0400
Date: Sun, 14 Apr 2002 13:17:33 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Russell King <rmk@arm.linux.org.uk>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8-pre3 full compile - errors
In-Reply-To: <20020414105343.A30748@flint.arm.linux.org.uk>
Message-ID: <Pine.NEB.4.44.0204141316250.5235-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2002, Russell King wrote:

> On Sun, Apr 14, 2002 at 07:39:38PM +1000, Keith Owens wrote:
> > FB_CYBER2000
>
> As far as I'm aware, it builds.  It certainly builds on ARM.  What were
> the errors (you didn't list them.)

???

Keith did list the errors in his mail. The FB_CYBER2000 error seems to be:

<--  snip  -->

drivers/video/cyber2000fb.c: In function `cyberpro_pci_probe':
drivers/video/cyber2000fb.c:1707: `MCLK_MULT' undeclared (first use in
this function)
drivers/video/cyber2000fb.c:1708: `MCLK_DIV' undeclared (first use in this
function)

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

