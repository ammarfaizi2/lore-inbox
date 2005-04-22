Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVDVRxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVDVRxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 13:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVDVRxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 13:53:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:15750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262087AbVDVRxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 13:53:17 -0400
Date: Fri, 22 Apr 2005 10:51:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, rth@twiddle.net, adaplas@pol.net,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c, tgafb not working anymore
In-Reply-To: <Pine.LNX.4.61L.0504221840180.27531@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0504221051240.2344@ppc970.osdl.org>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de>
 <20050422072858.GU607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi>
 <20050422144047.GY607@vega.lnet.lut.fi> <Pine.LNX.4.58.0504221024470.2344@ppc970.osdl.org>
 <Pine.LNX.4.61L.0504221840180.27531@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Apr 2005, Maciej W. Rozycki wrote:
> 
>  JFTR, a few of the TURBOchannel variations of the TGA are supported for 
> MIPS, but regrettably the necessary code hasn't been ported from 2.4 to 
> 2.6 yet.

Ok, so that would have increased the testing base by, what? One person or 
two? I think we're still in single digits ;)

			Linus
