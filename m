Return-Path: <linux-kernel-owner+w=401wt.eu-S1750821AbXAIAx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbXAIAx4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbXAIAx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:53:56 -0500
Received: from ms-smtp-05.ohiordc.rr.com ([65.24.5.139]:35376 "EHLO
	ms-smtp-05.ohiordc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbXAIAxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:53:55 -0500
Subject: Re: PROBLEM: LSIFC909 mpt card fails to recognize devices
From: Justin Rosander <myrddinemrys@neo.rr.com>
To: Eric Moore <eric.moore@lsil.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20070105035526.GA14185@lsil.com>
References: <1167955606.5133.13.camel@localhost>
	 <20070104165922.137c6df9.akpm@osdl.org>  <20070105035526.GA14185@lsil.com>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 19:53:47 -0500
Message-Id: <1168304027.5403.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Success! Here you are:
00:00.0 0600: 1106:3189 (rev 80)
        Subsystem: 1458:5000
        Flags: bus master, 66MHz, medium devsel, latency 8
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
        Capabilities: [c0] Power Management version 2

00:01.0 0604: 1106:b198
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Capabilities: [80] Power Management version 2

00:0a.0 0401: 1102:0004 (rev 04)
        Subsystem: 1102:1003
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at c000 [size=64]
        Capabilities: [dc] Power Management version 2

00:0a.2 0c00: 1102:4001 (rev 04) (prog-if 10)
        Subsystem: 1102:0010
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at e3035000 (32-bit, non-prefetchable) [size=2K]
        Memory at e3030000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

00:0b.0 0480: 1131:7133 (rev 10)
        Subsystem: 1043:4843
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at e3034000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [40] Power Management version 2

00:0c.0 0100: 1000:0621 (rev 01)
        Subsystem: 10cd:1000
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        I/O ports at c400 [size=256]
        Memory at e3000000 (64-bit, non-prefetchable) [size=128K]
        Memory at e3020000 (64-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at 30000000 [disabled] [size=1M]
        Capabilities: [40] Power Management version 2

00:0f.0 0101: 1106:0571 (rev 06) (prog-if 8a)
        Subsystem: 1458:5002
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at c800 [size=16]
        Capabilities: [c0] Power Management version 2

00:10.0 0c03: 1106:3038 (rev 81)
        Subsystem: 1458:5004
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 0c03: 1106:3038 (rev 81)
        Subsystem: 1458:5004
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 0c03: 1106:3038 (rev 81)
        Subsystem: 1458:5004
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 0c03: 1106:3038 (rev 81)
        Subsystem: 1458:5004
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2

00:10.4 0c03: 1106:3104 (rev 86) (prog-if 20)
        Subsystem: 1458:5004
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at e3036000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 0601: 1106:3227
        Subsystem: 1458:5001
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.5 0401: 1106:3059 (rev 60)
        Subsystem: 1458:a002
        Flags: medium devsel, IRQ 10
        I/O ports at dc00 [size=256]
        Capabilities: [c0] Power Management version 2

00:12.0 0200: 1106:3065 (rev 78)
        Subsystem: 1458:e000
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e000 [size=256]
        Memory at e3037000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

01:00.0 0300: 10de:0172 (rev a3)
        Subsystem: 1545:0035
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 11
        Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Memory at dc000000 (32-bit, prefetchable) [size=512K]
        [virtual] Expansion ROM at dc080000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0


On Thu, 2007-01-04 at 20:55 -0700, Eric Moore wrote:
> On Thu, Jan 04, 2007 at 04:59:22PM -0800, Andrew Morton wrote:
> > On Thu, 04 Jan 2007 19:06:46 -0500
> > Justin Rosander <myrddinemrys@neo.rr.com> wrote:
> > 
> > > Please forward this to the appropriate maintainer.  Thank you.
> > > 
> > > [1.] One line summary of the problem:    My fibre channel drives fail to
> > > be recognized by my LSIFC909 card. 
> > 
> > Please send the output of `lspci -vn'
> > -
> 
> Recompile the driver with MPT_DEBUG_INIT enabled in the driver Makefile,
> and repost the output.
> 
> Eric Moore

