Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVHKHJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVHKHJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 03:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVHKHJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 03:09:52 -0400
Received: from b.relay.invitel.net ([62.77.203.4]:30629 "EHLO
	b.relay.invitel.net") by vger.kernel.org with ESMTP
	id S1750724AbVHKHJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 03:09:52 -0400
Date: Thu, 11 Aug 2005 09:09:43 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Allen Martin <AMartin@nvidia.com>
Cc: Michael Thonke <iogl64nx@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
Message-ID: <20050811070943.GB8025@vega.lgb.hu>
Reply-To: lgb@lgb.hu
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>
X-Operating-System: vega Linux 2.6.12-6-686 i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Hmm, I can't understand this. I want to buy a new system including
motherboard with some Athlon64 CPU. I was told that nforce4 chipset is the
"right" choice. However I'm using *only* Linux (well, sometimes BSDs,
Solaris and such) and I have *never* had windows installed on any of my
computers. Also I know *lots* of relatives/friends/collegues/etc using Linux
or other UNIX only or at least mainly. Deciding not to support the need of
these people mean market loss, even if you count the publish info and/or
source code to eg build and/or extend a storage driver will *NOT* effect any
other company or such, at least I can't understand why a company afraid
releasing info to support some stuff ... Well ok, maybe a 3D video card is
another topic, but now we're only talking about NCQ which needs some port
read/write operations and such (at least I can beleive this, I do direct hw
IDE programming back to the time of 286s).

Seriously, should I avoid motherboards with nvidia chipset? Or what can I
do? Everybody says "OK, next product will be better for your needs", but
I need my new machine *NOW* ...

On Wed, Aug 10, 2005 at 01:53:47PM -0700, Allen Martin wrote:
> > Erm, why they are not willing to support NCQ under Linux...I 
> > mean many 
> > people using NVIDIA based mainboards. And that against that what I 
> > thought NVidia stands for - Linux friendly but seems only that this 
> > statement fit on graficcards? Is there no "responsible" person that 
> > says...Hello, Linux is a growing market that we need to 
> > serve? With full 
> > driver/program support?
> > 
> 
> Likely the only way nForce4 NCQ support could be added under Linux would
> be with a closed source binary driver, and no one really wants that,
> especially for storage / boot volume.  We decided it wasn't worth the
> headache of a binary driver for this one feature.  Future nForce
> chipsets will have a redesigned SATA controller where we can be more
> open about documenting it.

-- 
- Gábor
