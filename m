Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271371AbRICINy>; Mon, 3 Sep 2001 04:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271399AbRICINn>; Mon, 3 Sep 2001 04:13:43 -0400
Received: from pv182180.reshsg.uci.edu ([128.195.182.180]:7410 "EHLO
	pranika.wulf") by vger.kernel.org with ESMTP id <S271371AbRICINc>;
	Mon, 3 Sep 2001 04:13:32 -0400
Subject: Re: Athlon doesn't like Athlon optimisation?
To: linux-kernel@vger.kernel.org
Date: Mon, 3 Sep 2001 01:13:51 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dorf-0003vE-00@pranika.wulf>
From: Eric Olson <ejolson%pranika@fractal.math.unr.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found these Athlon problems are very interesting.

Is there a usermode memory testing program which uses the K7 MMX 3DNow
streaming cache bypass load/store instruction sequences that appear in
linux/arch/i386/lib/mmx.c ?

Could Robert Redelmeier's burnMMX at 
	http://users.ev1.net/~redelm/
be modified for the Athlon to detect these problems?

It would be usefull to have a Microsoft Windows program that could 
detect a faulty system without having to load Linux.  This would allow 
testing a system in a store before purchase, and quick testing of a 
new system shipped with Windows to determine whether it needs to be 
returned before reformatting the harddisk and installing Linux.

The reports I've know are for KT133 motherboards.  Have problems been 
reported with the KT266 DDR-SDRAM chipsets as well?

All the best, Eric Olson
