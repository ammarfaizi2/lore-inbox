Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287371AbRL3KBO>; Sun, 30 Dec 2001 05:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287367AbRL3KBE>; Sun, 30 Dec 2001 05:01:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41222 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287371AbRL3KAq>; Sun, 30 Dec 2001 05:00:46 -0500
Subject: Re: The direction linux is taking
To: lm@bitmover.com (Larry McVoy)
Date: Sun, 30 Dec 2001 10:07:36 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), lm@bitmover.com (Larry McVoy),
        bcrl@redhat.com (Benjamin LaHaise),
        oxymoron@waste.org (Oliver Xymoron),
        wingel@hog.ctrl-c.liu.se (Christer Weinigel),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011229184921.B27114@work.bitmover.com> from "Larry McVoy" at Dec 29, 2001 06:49:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KcsS-0000hb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the human doing the merging.  So far, it seems more like nobody is 
> doing any merging, Dave says someone does but nobody else has spoken

Lots of people do. I get all my wireless, my isdn, my usb
patches all nicely prepacked and merged for example.

> up and I tend to think that merging is not a common process in the
> Linux tree, the rate of change sort of indicates that.  I suspect 

The primary limit on the rate of change is the rate at which Linus merges
stuff, nothing else.

> is happening in the Linux/PPC development nor the MySQL development.
> They have merge conflicts all the time and we have years of data to prove

For the ppc folks I guess because they are keeping a parallel tree. Thats a 
totally different animal because you collide continually with things you've
submitted and changes in the core tree.

Alan
