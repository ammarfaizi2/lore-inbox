Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317266AbSFGL1s>; Fri, 7 Jun 2002 07:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317267AbSFGL1r>; Fri, 7 Jun 2002 07:27:47 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:53998 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S317266AbSFGL1q>; Fri, 7 Jun 2002 07:27:46 -0400
Date: Fri, 7 Jun 2002 13:28:03 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andi Kleen <ak@suse.de>
cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] 4KB stack + irq stack for x86
In-Reply-To: <p73lm9schms.fsf@oldwotan.suse.de>
Message-ID: <Pine.GSO.3.96.1020607132043.16482F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jun 2002, Andi Kleen wrote:

> Seems to be an old myth. Actually the 4K paged 64bit platforms are in the majority.
> 
> 64bit linux platforms:
> 
> 4K page: x86-64, ppc64, s390x, mips64, parisc64(?)
> 8K:	 alpha, sparc64
> 8-64K:   ia64

 MIPS64 is 4K-16M (per page), currently fixed at 4K, but it can be changed
if desireable.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

