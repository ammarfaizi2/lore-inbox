Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278538AbRJ3Nb2>; Tue, 30 Oct 2001 08:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278908AbRJ3NbS>; Tue, 30 Oct 2001 08:31:18 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:41645 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S278538AbRJ3NbC>; Tue, 30 Oct 2001 08:31:02 -0500
Date: Tue, 30 Oct 2001 14:14:50 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] making the printk buffer bigger 
In-Reply-To: <3645339074.1004372719@mbligh.des.sequent.com>
Message-ID: <Pine.GSO.3.96.1011030135941.6694E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Martin J. Bligh wrote:

> OK, seeing as people don't seem to want a decent size buffer on 
> CONFIG_SMP machines, could we at least do it under
> CONFIG_MULTIQUAD? Loosing half my boot time messages is 
> annoying, and I have gigabytes of RAM to waste. Please .......

 Hmm, and what exactly does prevent you from applying the patch privately
for the time you are needing it for developent?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

