Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267572AbSKQUEh>; Sun, 17 Nov 2002 15:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbSKQUEh>; Sun, 17 Nov 2002 15:04:37 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:17130 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267572AbSKQUEg>;
	Sun, 17 Nov 2002 15:04:36 -0500
Date: Sun, 17 Nov 2002 20:10:26 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021117201026.GB1851@bjl1.asuk.net>
References: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211161915360.1337-100000@home.transmeta.com> <20021116193008.C25741@work.bitmover.com> <m11y5k3ruw.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11y5k3ruw.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> As long as the network console/debug interface includes basic a basic
> check to verify that the packets it accepts are from the local network.
> And it's outgoing packets have a ttl of one.  I don't have a problem.

Is there a working network console?  It would be _great_ to have a
network console to my _remote_ server, far far away on the internet.

-- Jamie
