Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264827AbRFSW5q>; Tue, 19 Jun 2001 18:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264829AbRFSW50>; Tue, 19 Jun 2001 18:57:26 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:16388 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S264827AbRFSW5S>;
	Tue, 19 Jun 2001 18:57:18 -0400
Message-ID: <3B2FD8D6.ED04B275@bigfoot.com>
Date: Tue, 19 Jun 2001 16:57:26 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@ufl.edu>
Cc: Daniel Bertrand <d.bertrand@ieee.ca>,
        emu10k1-devel <emu10k1-devel@opensource.creative.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Emu10k1-devel] Re: Buggy emu10k1 drivers.
In-Reply-To: <Pine.LNX.4.33.0106171449470.2175-100000@kilrogg> <992822448.3798.6.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
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


Tried 2.4.5 and 2.2.19 with the same snapshot code (emu10k1-20010617.tar.gz)

2.4.5 works, 2.2.19 doesn't.

Maybe 2.2.19 has deeper problems with my hardware which aren't in the
driver, then, as identical code works on one and not the other.

--
    www.kuro5hin.org -- technology and culture, from the trenches.
