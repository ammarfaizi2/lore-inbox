Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUAPSJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbUAPSJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:09:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:33232 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265494AbUAPSJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:09:02 -0500
Date: Fri, 16 Jan 2004 10:04:45 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: ak@colin2.muc.de, george@mvista.com, ak@muc.de,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Message-Id: <20040116100445.0dfde09e.rddunlap@osdl.org>
In-Reply-To: <20040116011510.GM28521@waste.org>
References: <1d3r0-1tw-3@gated-at.bofh.it>
	<1dbI9-89t-7@gated-at.bofh.it>
	<1dEqx-F0-1@gated-at.bofh.it>
	<1dMRc-6DQ-3@gated-at.bofh.it>
	<1e2Mk-6YA-17@gated-at.bofh.it>
	<1e2Mo-6YA-31@gated-at.bofh.it>
	<1e3fi-4nG-5@gated-at.bofh.it>
	<m3ptdlwsf5.fsf@averell.firstfloor.org>
	<4006512A.7080002@mvista.com>
	<20040115085217.GA43298@colin2.muc.de>
	<20040116011510.GM28521@waste.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004 19:15:10 -0600 Matt Mackall <mpm@selenic.com> wrote:

| On Thu, Jan 15, 2004 at 09:52:17AM +0100, Andi Kleen wrote:
| > On Thu, Jan 15, 2004 at 12:36:58AM -0800, George Anzinger wrote:
| > > Now that is interesting.  As I read it, the debug port is programed the 
| > > same way in all the USB chips (given it exists at all).  AND it is much 
| > 
| > Yep, it's not PIO, but polled MMIO. Sorry for spreading misinformation.
| > 
| > > easier to use. Anyone care to put together a polling driver that makes it 
| > > look like RS232 on the host end given that we use a controller to 
| > > controller cable?
| > 
| > I suspect all laptop users with kernel bugs will admire whoever does that ;-)
| 
| I've been thinking about doing this, may get around to it eventually.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I'd like to help also, but I don't have ICH4 or other usb-debug
hardware AFAIK.

--
~Randy
Everything is relative.
