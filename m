Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbTICJYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbTICJYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:24:17 -0400
Received: from ip119-170.introweb.nl ([80.65.119.170]:46976 "EHLO
	laptop.locamation.com") by vger.kernel.org with ESMTP
	id S261537AbTICJYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:24:14 -0400
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
From: Kars de Jong <jongk@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0309031004480.6985-100000@waterleaf.sonytel.be>
References: <Pine.GSO.4.21.0309031004480.6985-100000@waterleaf.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1062581043.1221.72.camel@laptop.locamation.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Sep 2003 11:24:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 10:05, Geert Uytterhoeven wrote:
> On 3 Sep 2003, Kars de Jong wrote:
> > On Mon, 2003-09-01 at 10:34, Geert Uytterhoeven wrote:
> > > BTW, probably you want us to run your test program on other m68k boxes? Mine
> > > got a 68040, that leaves us with:
> > >   - 68030
> > 
> > Ah, I forgot, I've got one of these here too, a Motorola MVME147 board:
> > 
> > sasscm:/tmp# time ./jamie_test2
> > Test separation: 4096 bytes: FAIL - cache not coherent
> 
> I guess the Plessey PME 68-22 didn't have cache, since the test passed?

No, no cache. Well. A very tiny instruction cache in the 68020 itself.

Regards,

Kars.

