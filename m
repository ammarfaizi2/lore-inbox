Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSEaVkE>; Fri, 31 May 2002 17:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316954AbSEaVkD>; Fri, 31 May 2002 17:40:03 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:4238 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316953AbSEaVkC>;
	Fri, 31 May 2002 17:40:02 -0400
Date: Fri, 31 May 2002 23:36:51 +0200
From: Nikolaus Filus <NFilus@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: de4x5 driver: driver freezes system
Message-ID: <20020531233651.B595@nfilus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a maintainer (one of several :) of a little linux distribution called
rocklinux (www.rocklinux.org) and tried to make a fits-for-everyone kernel,
but got some booting problems with the de4x5 driver.
When compiling the driver into the kernel and no appropriate card is
installed in the system the booting stops and the computer freezes. I tested
this with kernel 2.4.16 and .18 on my Toshiba laptop and reported by other
users. I would like to provide more information, when needed - just say what

I also tried to contact the maintainer mentionod in the driver itself, but
the mail returns.

Nikolaus Filus
