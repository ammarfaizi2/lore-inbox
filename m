Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbSKETw4>; Tue, 5 Nov 2002 14:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265172AbSKETw4>; Tue, 5 Nov 2002 14:52:56 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:48311 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265171AbSKETwz>; Tue, 5 Nov 2002 14:52:55 -0500
Date: Tue, 5 Nov 2002 12:56:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rob Landley <landley@trommello.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_TINY
Message-ID: <20021105195616.GF13102@opus.bloom.county>
References: <20021104195144.GC27298@opus.bloom.county> <Pine.LNX.3.96.1021105141149.17410L-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021105141149.17410L-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 02:26:08PM -0500, Bill Davidsen wrote:
> On Mon, 4 Nov 2002, Tom Rini wrote:
> 
> > On Mon, Nov 04, 2002 at 02:13:48AM +0000, Rob Landley wrote:
> 
> > > I've used -Os.  I've compiled dozens and dozens of packages with -Os.  It has 
> > > always saved at least a few bytes, I have yet to see it make something 
> > > larger.  And in the benchmarks I've done, the smaller code actually runs 
> > > slightly faster.  More of it fits in cache, you know.
> > 
> > Then we don't we always use -Os?
>
[snip 6 good reasons]

So why do we want to force it on for CONFIG_TINY?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
