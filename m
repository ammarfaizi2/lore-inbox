Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbTJPKm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTJPKm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:42:27 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:42408 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262802AbTJPKm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:42:26 -0400
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031016101905.GA7454@casa.fluido.as>
References: <20031015162056.018737f1.akpm@osdl.org>
	 <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org>
	 <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston>
	 <20031016101905.GA7454@casa.fluido.as>
Content-Type: text/plain
Message-Id: <1066300892.646.134.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 16 Oct 2003 12:41:32 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 12:19, Carlo E. Prelz wrote:
> 	Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
> 	Date: gio, ott 16, 2003 at 12:00:32 +0200
> 
> Quoting Benjamin Herrenschmidt (benh@kernel.crashing.org):
> 
> > My new driver (bk://ppc.bkbits.net/linuxppc-2.5-benh) now uses a copy
> > of XFree PCI IDs list, making it much easier to keep in sync. It should
> > also support the 9200.
> 
> The latest (*NON*bk) patch distributed by James appears to include your
> new driver. The header from radeon_base.c  reads:

I think it's an older version that James included as the current one
has support for the 9200. I'm still updating it very regulary as it's
not considered as "finished" work yet :) Though testing is welcome,
I try to keep it working at any stage.

Ben.


