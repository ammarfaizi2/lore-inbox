Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265832AbSKBAXF>; Fri, 1 Nov 2002 19:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265833AbSKBAXF>; Fri, 1 Nov 2002 19:23:05 -0500
Received: from air-2.osdl.org ([65.172.181.6]:35281 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265832AbSKBAXF>;
	Fri, 1 Nov 2002 19:23:05 -0500
Date: Fri, 1 Nov 2002 16:25:33 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andries Brouwer <aebr@win.tue.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [announce] swap mini-howto
In-Reply-To: <20021102001947.GA461@win.tue.nl>
Message-ID: <Pine.LNX.4.33L2.0211011622120.28320-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Andries Brouwer wrote:

| On Fri, Nov 01, 2002 at 03:58:27PM -0800, Randy.Dunlap wrote:
|
| >   http://www.xenotime.net/linux/swap-mini-howto.txt
|
| Maybe either refer to 'man mkswap' or add a sentence
| about versions. (If you boot both 2.0 and 2.2 then
| use mkswap -v0 to get swap space also 2.0 can use.)
Will do.

BTW, my current (maybe outdated?) mkswap.8 page says:
       Presently,  Linux  allows  8  swap  areas. The areas in use
       can be seen in the file /proc/swaps (since 2.1.25).

However, the current (2.5) source code supports 32 swap areas.
I don't know when this was changed...

-- 
~Randy

