Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263015AbRFQWVG>; Sun, 17 Jun 2001 18:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263020AbRFQWU4>; Sun, 17 Jun 2001 18:20:56 -0400
Received: from mail1.rdc2.bc.home.com ([24.2.10.84]:16043 "EHLO
	mail1.rdc2.bc.home.com") by vger.kernel.org with ESMTP
	id <S263015AbRFQWUo>; Sun, 17 Jun 2001 18:20:44 -0400
Date: Sun, 17 Jun 2001 15:17:41 -0700 (PDT)
From: Daniel Bertrand <d.bertrand@ieee.ca>
X-X-Sender: <d_bertra@kilrogg>
To: Dylan Griffiths <Dylan_G@bigfoot.com>
cc: emu10k1-devel <emu10k1-devel@opensource.creative.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Emu10k1-devel] Re: Buggy emu10k1 drivers.
In-Reply-To: <3B2C8BFE.299BD47@bigfoot.com>
Message-ID: <Pine.LNX.4.33.0106171449470.2175-100000@kilrogg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2001, Dylan Griffiths wrote:

> 	Kernel 2.4.5 has a working emu10k1 driver (all apps which hung with
> 2.2.19's driver worked fine, none of the working ones stopped working).
> Could we perhaps see this backported to the 2.2.20 prepatches so that us 2.2
> lovers can enjoy working sound?

Can you give the CVS driver a try? Snapshots are available here:
http://opensource.creative.com/snapshot.html

The driver in the kernel is based on a CVS snapshot from last summer, the
problem may be fixed in CVS. Also, the CVS driver is a common driver for
2.2 and 2.4 (with some #ifdef), so it may be useful to see if it works for
you on 2.4.5 but not on 2.2.19.


-- 
Daniel Bertrand

