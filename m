Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUDSSLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 14:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUDSSLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 14:11:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:31960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261661AbUDSSLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 14:11:35 -0400
Date: Mon, 19 Apr 2004 11:05:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: [PATCH] floppy98.c: use kernel min/max
Message-Id: <20040419110553.47a588d1.rddunlap@osdl.org>
In-Reply-To: <20040419180522.A14468@infradead.org>
References: <20040418194357.4cd02a06.rddunlap@osdl.org>
	<200404191414.15702.bzolnier@elka.pw.edu.pl>
	<20040419085116.1d8576a6.rddunlap@osdl.org>
	<200404191859.29846.bzolnier@elka.pw.edu.pl>
	<20040419180522.A14468@infradead.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 18:05:22 +0100 Christoph Hellwig wrote:

| On Mon, Apr 19, 2004 at 06:59:29PM +0200, Bartlomiej Zolnierkiewicz wrote:
| > BTW at least PC9800 IDE support needs reworking - it is one BIG hack
| 
| Please just kill it then.  PC9800 wasn't completly merged ever and there
| haven't been atempts for ages.  No need to stall development because of it.

Is some development stalled because of it?

The current (status quo) isn't good.
It either needs to be fixed or removed.

--
~Randy
