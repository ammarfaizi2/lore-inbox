Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWGRSlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWGRSlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWGRSlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:41:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932350AbWGRSlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:41:35 -0400
Date: Tue, 18 Jul 2006 14:40:52 -0400
From: Dave Jones <davej@redhat.com>
To: febo@delenda.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'vintage' via dma bug
Message-ID: <20060718184052.GA9679@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, febo@delenda.net,
	linux-kernel@vger.kernel.org
References: <001001c6aa99$0476a380$fc01a8c0@EFFEPUNTO>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001c6aa99$0476a380$fc01a8c0@EFFEPUNTO>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2006 at 08:36:00PM +0200, febo@delenda.net wrote:
 > I have the misfortune to run a rather old PIII machine with a VIA chipset, 
 > a Fedora Core 1 distro with 2.4.22 kernel and two PATA hard mirrored hard 
 > disk, on two separate channels, both set to primary. I've experienced some 
 > data corruption lately and after much googling I've found that 4-5 years 
 > ago some via chipset experienced a similar problem with dma transfers, 
 > especially with hard disk configured the very same way as my setup. The bug 
 > was fixed, I gather, in 2.4.4. I've upgrade the kernel to 2.6.10 (the 
 > latest Fedora legacy core *TWO* kernel, with fingers crossed) but the 
 > corruption problems usually start to pop up only after a few weeks of 
 > uptime, especially under relatively heavy load.
 > I couldn't find more precise pointers after all these years so I'd like to 
 > know if that bug really affected my chipset, and if 2.6.10 is a valid 
 > solution.. 

I'm puzzled why you upgraded from one end-of-life'd distro to
another ancient end-of-life'd distro.   You're more likely to get
interest from the upstream developers if you're running
something recent.  Even _I_ don't remember what was good/bad
in the Fedora kernels from that era, and I built them :-)

		Dave

-- 
http://www.codemonkey.org.uk
