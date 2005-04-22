Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVDVSHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVDVSHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 14:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVDVSHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 14:07:45 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:61191 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262100AbVDVSHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 14:07:41 -0400
Date: Fri, 22 Apr 2005 19:07:50 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, rth@twiddle.net, adaplas@pol.net,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c, tgafb not working anymore
In-Reply-To: <Pine.LNX.4.58.0504221051240.2344@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61L.0504221903320.27531@blysk.ds.pg.gda.pl>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de>
 <20050422072858.GU607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi>
 <20050422144047.GY607@vega.lnet.lut.fi> <Pine.LNX.4.58.0504221024470.2344@ppc970.osdl.org>
 <Pine.LNX.4.61L.0504221840180.27531@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58.0504221051240.2344@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2005, Linus Torvalds wrote:

> >  JFTR, a few of the TURBOchannel variations of the TGA are supported for 
> > MIPS, but regrettably the necessary code hasn't been ported from 2.4 to 
> > 2.6 yet.
> 
> Ok, so that would have increased the testing base by, what? One person or 
> two? I think we're still in single digits ;)

 Except that once I get them running with 2.6 I'll try keeping an eye on 
the driver so that nothing gets broken at least for the more useful 
configurations. 8-)

  Maciej
