Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132035AbRARJKl>; Thu, 18 Jan 2001 04:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132249AbRARJKb>; Thu, 18 Jan 2001 04:10:31 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:42480 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132035AbRARJKY>; Thu, 18 Jan 2001 04:10:24 -0500
Date: Thu, 18 Jan 2001 09:37:53 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dan Hollis <goemon@sasami.anime.net>
cc: Martin Mares <mj@suse.cz>, Adam Lackorzynski <al10@inf.tu-dresden.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset
In-Reply-To: <Pine.LNX.4.30.0101171314380.18147-100000@anime.net>
Message-ID: <Pine.GSO.3.96.1010118092306.8140D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Dan Hollis wrote:

> They require not only an NDA, but that you also do all development on-site
> at their santa clara HQ under their direct supervision.

 I haven't went that far -- I'm not going to sign any NDA anytime soon, so
I haven't asked them for details.  I recall someone writing here it's
restrictive, indeed. 

> The only people who have ever got info out of serverworks are the lm78
> guys and (i think) andre hedrick.

 I was asking for a few I/O APIC details -- apparently there are problems
with 8254 interoperability and we have to use the awkward through-8259A
mode for the timer tick.

> What magic incantations they chanted, or which mafia thugs they hired to
> manage this, I don't know...

 And I don't actually care.  If they want to lose in the Linux area, it's
their own choice. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
