Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265831AbSKBANW>; Fri, 1 Nov 2002 19:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265834AbSKBANW>; Fri, 1 Nov 2002 19:13:22 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:3910 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S265831AbSKBANW>;
	Fri, 1 Nov 2002 19:13:22 -0500
Date: Sat, 2 Nov 2002 01:19:47 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [announce] swap mini-howto
Message-ID: <20021102001947.GA461@win.tue.nl>
References: <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 03:58:27PM -0800, Randy.Dunlap wrote:

>   http://www.xenotime.net/linux/swap-mini-howto.txt

Maybe either refer to 'man mkswap' or add a sentence
about versions. (If you boot both 2.0 and 2.2 then
use mkswap -v0 to get swap space also 2.0 can use.)

Andries
