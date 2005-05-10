Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVEJTtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVEJTtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVEJTtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:49:16 -0400
Received: from picard.ine.co.th ([203.152.41.3]:40131 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S261765AbVEJTsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:48:51 -0400
Subject: Re: kernel (64bit) 4GB memory support
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050509200721.GE2297@csclub.uwaterloo.ca>
References: <Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com>
	 <1103027130.3650.73.camel@cpu0> <20041216074905.GA2417@c9x.org>
	 <1103213359.31392.71.camel@cpu0>
	 <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com>
	 <1103646195.3652.196.camel@cpu0>
	 <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com>
	 <1103647158.3659.199.camel@cpu0>
	 <Pine.LNX.4.61.0412210955130.28648@montezuma.fsmlabs.com>
	 <1115654185.3296.658.camel@cpu10>
	 <20050509200721.GE2297@csclub.uwaterloo.ca>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Date: Wed, 11 May 2005 02:48:42 +0700
Message-Id: <1115754522.4409.16.camel@cpu10>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 16:07 -0400, Lennart Sorensen wrote:
> On Mon, May 09, 2005 at 10:56:25PM +0700, Rudolf Usselmann wrote:
> > Just curious, did anybody ever look in to this at all ? I keep
> > on downloading new kernels and trying 4GB of memory - still no
> > luck.
> > 
> > I did file a bug report but didn't get any notifications at all.
> > I don't subscribe to the linux-kernel list so not sure if anything
> > ever came up or not.
> > 
> > Is there a way to get this fixed ?
> 
> How much ram do you see with 4GB installed running a 64bit kernel?
> 
> What does /proc/meminfo show?
> 
> How about the memory map dmesg shows at the start of boot?
> 
> Len Sorensen

I do see the full 4G. With Fedora Core 2 32bit, I can use all
4G as well. All my problems started when I "upgraded" to x86_64 ...

Best Regards,
rudi
=============================================================
Rudolf Usselmann,  ASICS World Services,  http://www.asics.ws
Your Partner for IP Cores, Design, Verification and Synthesis

