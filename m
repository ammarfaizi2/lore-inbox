Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVDVRpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVDVRpD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 13:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVDVRpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 13:45:03 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:37132 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262085AbVDVRoa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 13:44:30 -0400
Date: Fri, 22 Apr 2005 18:44:35 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, rth@twiddle.net, adaplas@pol.net,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c, tgafb not working anymore
In-Reply-To: <Pine.LNX.4.58.0504221024470.2344@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61L.0504221840180.27531@blysk.ds.pg.gda.pl>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de>
 <20050422072858.GU607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi>
 <20050422144047.GY607@vega.lnet.lut.fi> <Pine.LNX.4.58.0504221024470.2344@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2005, Linus Torvalds wrote:

> Most people don't have tga hardware. I don't think even most alpha users 
> have it, and I think it's unheard of outside of alpha. So I'm afraid that 
> there's not a lot of people around who can debug it without having a very 
> clear starting point..

 JFTR, a few of the TURBOchannel variations of the TGA are supported for 
MIPS, but regrettably the necessary code hasn't been ported from 2.4 to 
2.6 yet.

  Maciej
