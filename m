Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSKRGZa>; Mon, 18 Nov 2002 01:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSKRGZa>; Mon, 18 Nov 2002 01:25:30 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:1220 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261527AbSKRGZ3>;
	Mon, 18 Nov 2002 01:25:29 -0500
Date: Mon, 18 Nov 2002 07:32:30 +0100
From: bert hubert <ahu@ds9a.nl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: modutils url for: Re: Linux v2.5.48
Message-ID: <20021118063229.GA7327@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 08:41:05PM -0800, Linus Torvalds wrote:

> Hmm.. All over the place, best you see the changelog. Lots of small 
> cleanups (remove unnecessary header files etc), but a few more fundamental 
> changes too. Times in nsecs in stat64(), for example, and the 
> oft-discussed kernel module loader changes..

To get this to load modules, you need:
http://www.kernel.org/pub/linux/kernel/people/rusty/module-init-tools-0.7.tar.gz

Just to save you the searching.

Shameless plug: to play with the ipsec, see
http://lartc.org/howto/lartc.ipsec.html - should now work without further
patches!

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
