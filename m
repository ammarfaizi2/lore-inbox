Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267412AbTAGQ03>; Tue, 7 Jan 2003 11:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267418AbTAGQ02>; Tue, 7 Jan 2003 11:26:28 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14085 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267412AbTAGQ02>; Tue, 7 Jan 2003 11:26:28 -0500
Date: Tue, 7 Jan 2003 11:32:48 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Matthias Andree <matthias.andree@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Honest does not pay here ...
In-Reply-To: <20030107012429.GA12944@merlin.emma.line.org>
Message-ID: <Pine.LNX.3.96.1030107112114.15952B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2003, Matthias Andree wrote:

> Only that you can't trust in the el-cheapo vendors claiming Linux
> support, and an independent certification is needed (not only for Linux,
> for the *BSDs as well). Without a trusted certification, some crooks may
> try to claim Linux support and it won't quite work out.

To be honest, support for Windows is much easier than Linux. There are
only a few versions of Windows out, in terms of how many versions are
needed, and in many cases the same driver will work for several versions.

For Linux, there are not only dozens of kernel versions around, but the
uni and smp versions are not the same. Vendors who want to provide drivers
really want to provide the binary even if the module is open source, just
because the average person has no desire to build any part of a kernel.

So it is possible to release a driver and claim in good faith that it
works, and still not have it work with *your* system. Not because the
vendor is evil, incompetent, a "crook" (your term), dishonest, or even
that testing was poor, but because all kernels are very much not created
equal. 

Try to understand why vendors want to ship binary modules and why they
don't always work before making accusations.

All that said, an independent testing service would be of use to the
vendors, because they could find things before shipping and have someone
to share the blame if the module didn't work with another kernel.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

