Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbTAJQdT>; Fri, 10 Jan 2003 11:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbTAJQdT>; Fri, 10 Jan 2003 11:33:19 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:34546
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265402AbTAJQcR>; Fri, 10 Jan 2003 11:32:17 -0500
Date: Fri, 10 Jan 2003 11:41:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Dave Jones <davej@codemonkey.org.uk>
cc: William Lee Irwin III <wli@holomorphy.com>, "" <torvalds@transmeta.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <20030110162834.GB23375@codemonkey.org.uk>
Message-ID: <Pine.LNX.4.50.0301101139000.7163-100000@montezuma.mastecende.com>
References: <20030110161012.GD2041@holomorphy.com> <20030110162834.GB23375@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Dave Jones wrote:

> There's still a boatload of drivers that don't compile,
> a metric shitload of bits that never came over from 2.4 after
> I stopped doing it circa 2.4.18, a lot of little 'trivial'
> patches that got left by the wayside, and a load of 'strange' bits
> that still need nailing down (personally, I have two boxes
> that won't boot a 2.5 kernel currently (One was pnpbios related,

I had a problem with PCI init, pnpbios ordering at some point, but i
haven't tried a kernel with pnpbios in a while.

> other needs more investigation), and another that falls on its
> face after 10 minutes idle uptime. My p4-ht desktop box is the only one
> that runs 2.5 without any problems.

Thats interesting, i have a laptop experiencing the same symptoms, i'll be
looking at it over the weekend.

	Zwane
-- 
function.linuxpower.ca
