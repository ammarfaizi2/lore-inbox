Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbRFRA2h>; Sun, 17 Jun 2001 20:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbRFRA21>; Sun, 17 Jun 2001 20:28:27 -0400
Received: from mail2.rdc2.bc.home.com ([24.2.10.85]:4854 "EHLO
	mail2.rdc2.bc.home.com") by vger.kernel.org with ESMTP
	id <S263212AbRFRA2N>; Sun, 17 Jun 2001 20:28:13 -0400
Date: Sun, 17 Jun 2001 17:25:11 -0700 (PDT)
From: Daniel Bertrand <d.bertrand@ieee.ca>
X-X-Sender: <d_bertra@kilrogg>
To: Robert Love <rml@ufl.edu>
cc: Dylan Griffiths <Dylan_G@bigfoot.com>,
        emu10k1-devel <emu10k1-devel@opensource.creative.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Emu10k1-devel] Re: Buggy emu10k1 drivers.
In-Reply-To: <992822448.3798.6.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0106171707150.2262-100000@kilrogg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jun 2001, Robert Love wrote:

> On 17 Jun 2001 15:17:41 -0700, Daniel Bertrand wrote:
> > Can you give the CVS driver a try? Snapshots are available here:
> > http://opensource.creative.com/snapshot.html
> >
> > The driver in the kernel is based on a CVS snapshot from last summer, the
> > problem may be fixed in CVS. Also, the CVS driver is a common driver for
> > 2.2 and 2.4 (with some #ifdef), so it may be useful to see if it works for
> > you on 2.4.5 but not on 2.2.19.
>
> if the driver in the kernel is that old, could we try merging a newer
> release?  is there any reason why it has not been done yet?

A patch was submitted to Alan in April but appears to have never made it
in, I'm not sure what his reason was.


-- 
Daniel Bertrand



