Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVL0NSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVL0NSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 08:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVL0NSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 08:18:16 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:25289 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S932170AbVL0NSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 08:18:16 -0500
Date: Tue, 27 Dec 2005 08:17:53 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: ati X300 support?
In-Reply-To: <200512270149.24440.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0512270817340.15649@innerfire.net>
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net>
 <200512270149.24440.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The raedon drm module does not seem to detect the card.

	Gerhard


On Tue, 27 Dec 2005, Alistair John Strachan wrote:

> Date: Tue, 27 Dec 2005 01:49:24 +0000
> From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
> To: Gerhard Mack <gmack@innerfire.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: ati X300 support?
> 
> On Monday 26 December 2005 23:59, Gerhard Mack wrote:
> > hello,
> >
> > Does anyone know when there will be working support for the ATI X300 I
> > tried the latest kernel (2.6.15-rc7) but I don't see drivers for it.
> 
> The only support the kernel should and currently does provide for this 
> hardware is the "radeon" drm module. I believe the X300 is an R3xx core, so 
> you might find it's supported minimally in the current Xorg release 
> (6.9.0/7.0.0). My Mobility Radeon 9600 seems to work fine with this 
> combination.
> 
> Alternatively you may want to look into running ATI's proprietary driver 
> (fglrx). Both are compatible with 2.6.14.
> 
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
