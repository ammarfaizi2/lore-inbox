Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752300AbWAEXdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbWAEXdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbWAEXdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:33:25 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6614 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752300AbWAEXdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:33:18 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Hannu Savolainen <hannu@opensound.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601060109130.27932@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de>
	 <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl>
	 <200601031629.21765.s0348365@sms.ed.ac.uk>
	 <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de>
	 <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de>
	 <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	 <20060103215654.GH3831@stusta.de>
	 <9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com>
	 <s5hpsn8md1j.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr>
	 <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de>
	 <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr>
	 <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de>
	 <1136486021.31583.26.camel@mindpipe>
	 <Pine.LNX.4.61.0601060109130.27932@zeus.compusonic.fi>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 18:33:16 -0500
Message-Id: <1136503996.847.85.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 01:19 +0200, Hannu Savolainen wrote:
> On Thu, 5 Jan 2006, Lee Revell wrote:
> 
> > On Thu, 2006-01-05 at 13:44 +0100, Marcin Dalecki wrote:
> > > Second - you still didn't explain why this allows you to conclude  
> > > that sound mixing should in no way be done inside the kernel. 
> > 
> > It works perfectly right now in userspace.  Therefore it should not be
> > in the kernel.
> So all the complaints about dmix problems in the ALSA mailing lists are 
> just exceptions that prove the above statement to be true.

No, it just means ALSA like the kernel is a work in progress.  Anyway
almost all the known issues have been fixed.  It works perfectly for the
vast majority of users.

Are all the Oopses posted to LKML evidence that the kernel is
fundamentally broken?

Lee

