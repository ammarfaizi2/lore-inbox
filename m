Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbSL0Wrx>; Fri, 27 Dec 2002 17:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbSL0Wrx>; Fri, 27 Dec 2002 17:47:53 -0500
Received: from bgp926777bgs.brghtn01.mi.comcast.net ([68.41.8.22]:10114 "EHLO
	comcast.net") by vger.kernel.org with ESMTP id <S265198AbSL0Wrw>;
	Fri, 27 Dec 2002 17:47:52 -0500
Date: Fri, 27 Dec 2002 17:56:17 +0000 (UTC)
From: Alex Goddard <agoddard@purdue.edu>
To: Brad Tilley <rtilley@vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53 make modules_install problem
In-Reply-To: <200212270958.43939.rtilley@vt.edu>
Message-ID: <Pine.LNX.4.50L0.0212271751380.1209-100000@dust.ebiz-gw.wintek.com>
References: <200212270958.43939.rtilley@vt.edu>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2002, Brad Tilley wrote:

[Snip]

> What must I do to fix this?

Obtain the newest module-init-tools from:
http://www.kernel.org/pub/linux/kernel/people/rusty/modules

You may also find it helpful in the future to find a lkml archive 
( http://groups.google.com keeps one under linux.kernel, IIRC.  I use 
http://marc.theaimsgroup.com ), and search it for any problem you're 
having.  I mention this only because someone reports this "problem" about 
once a week, so it's been answered a bunch already.

I don't mean that as a flame or anything.  But if whatever problem you're
having has already been discussed, and addressed before, a little research
on your part will get you your answer more quickly than waiting for
someone on the lkml to answer it (which may never happen).

-- 
Alex Goddard
agoddard@purdue.edu
