Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272447AbTGZKXs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 06:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272448AbTGZKXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 06:23:47 -0400
Received: from u212-239-148-62.freedom.planetinternet.be ([212.239.148.62]:6404
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP id S272447AbTGZKXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 06:23:47 -0400
Message-Id: <200307261033.h6QAXTNh002916@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: James Simmons <jsimmons@infradead.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, nick black <dank@suburbanjihad.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC 
In-Reply-To: Your message of "Fri, 25 Jul 2003 01:07:15 BST."
             <Pine.LNX.4.44.0307250106220.7845-100000@phoenix.infradead.org> 
Date: Sat, 26 Jul 2003 12:33:29 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Actually, no. I've been stuck at 2.5.46 for *ages* due to a never ending 
> > succession of driver issues (still not all solved by the way). 2.5.72 was 
> > the next kernel I could actually try to use. A lot of change takes place
> > over that many kernel revisions.
>
> Which drivers issues ?

Nothing to worry about anymore. There were some matroxfb ones 
(oopses at boot only when actively using matroxfb, for instance) 
but also a ton of non-video related stuff: whenever one thing got 
fixed, something had been broken in the mean time. Some of it still 
not solved, by the way, (aha152x anyone?).

The matrox oopses were solved already before I applied Petr's 
matroxfb-2.5.72.gz patch.

MCE
