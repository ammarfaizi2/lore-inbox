Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbTAJRQz>; Fri, 10 Jan 2003 12:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbTAJRQz>; Fri, 10 Jan 2003 12:16:55 -0500
Received: from havoc.daloft.com ([64.213.145.173]:23508 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265484AbTAJRQy>;
	Fri, 10 Jan 2003 12:16:54 -0500
Date: Fri, 10 Jan 2003 12:25:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030110172535.GA25565@gtf.org>
References: <20030110161012.GD2041@holomorphy.com> <1042219147.31848.65.camel@irongate.swansea.linux.org.uk> <20030110170625.GE23375@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110170625.GE23375@codemonkey.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 05:06:25PM +0000, Dave Jones wrote:
> On Fri, Jan 10, 2003 at 05:19:08PM +0000, Alan Cox wrote:
> What's happening with the OSS drivers ?
> I'm still carrying a few hundred KB of changes from 2.4 for those.
> I'm not going to spent a day splitting them up, commenting them and pushing
> to Linus if we're going to be dropping various drivers.

I've been updating the via audio every now and again.

If sound/oss is staying for 2.6.0, we might as well merge the 2.4.x
changes.

	Jeff



