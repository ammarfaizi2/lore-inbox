Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262235AbSJQVvB>; Thu, 17 Oct 2002 17:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262237AbSJQVvB>; Thu, 17 Oct 2002 17:51:01 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18379 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262235AbSJQVu7>;
	Thu, 17 Oct 2002 17:50:59 -0400
Date: Thu, 17 Oct 2002 14:54:54 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: george anzinger <george@mvista.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
In-Reply-To: <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33L2.0210171453050.2499-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Linus Torvalds wrote:

| On Wed, 9 Oct 2002, george anzinger wrote:
| >
| > This patch, in conjunction with the "core" high-res-timers
| > patch implements high resolution timers on the i386
| > platforms.
|
| I really don't get the notion of partial ticks, and quite frankly, this
| isn't going into my tree until some major distribution kicks me in the
| head and explains to me why the hell we have partial ticks instead of just
| making the ticks shorter.
| -

Carrier Grade Linux is not a distro, but we do integrate these
patches into the CGL patches and will continue to use it.

Please consider adding it to 2.5.

Thanks,
-- 
~Randy

