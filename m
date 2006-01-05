Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWAEXWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWAEXWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWAEXWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:22:12 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:28262 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1750779AbWAEXWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:22:11 -0500
Date: Fri, 6 Jan 2006 01:19:32 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <1136486021.31583.26.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0601060109130.27932@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de>  <200601031522.06898.s0348365@sms.ed.ac.uk>
 <20060103160502.GB5262@irc.pl>  <200601031629.21765.s0348365@sms.ed.ac.uk>
  <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de> 
 <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> 
 <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> 
 <20060103215654.GH3831@stusta.de>  <9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com>
  <s5hpsn8md1j.wl%tiwai@suse.de>  <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr>
  <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de> 
 <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr> 
 <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de> <1136486021.31583.26.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Lee Revell wrote:

> On Thu, 2006-01-05 at 13:44 +0100, Marcin Dalecki wrote:
> > Second - you still didn't explain why this allows you to conclude  
> > that sound mixing should in no way be done inside the kernel. 
> 
> It works perfectly right now in userspace.  Therefore it should not be
> in the kernel.
So all the complaints about dmix problems in the ALSA mailing lists are 
just exceptions that prove the above statement to be true.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
