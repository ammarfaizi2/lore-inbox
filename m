Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265943AbSKBLNH>; Sat, 2 Nov 2002 06:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265944AbSKBLNH>; Sat, 2 Nov 2002 06:13:07 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:11632 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265943AbSKBLNG>;
	Sat, 2 Nov 2002 06:13:06 -0500
Date: Sat, 2 Nov 2002 12:19:33 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [announce] swap mini-howto
Message-ID: <20021102111933.GB461@win.tue.nl>
References: <20021102001947.GA461@win.tue.nl> <Pine.LNX.4.33L2.0211011622120.28320-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211011622120.28320-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 04:25:33PM -0800, Randy.Dunlap wrote:

> BTW, my current (maybe outdated?) mkswap.8 page says:
>        Presently,  Linux  allows  8  swap  areas. The areas in use
>        can be seen in the file /proc/swaps (since 2.1.25).
> 
> However, the current (2.5) source code supports 32 swap areas.
> I don't know when this was changed...

It was changed in 2.4.10.

Andries
