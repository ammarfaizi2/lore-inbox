Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264341AbTLBUGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbTLBUGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:06:37 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:20320 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264341AbTLBUGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:06:36 -0500
Date: Wed, 3 Dec 2003 07:05:36 +1100
From: Nathan Scott <nathans@sgi.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031203070536.A2022202@wobbly.melbourne.sgi.com>
References: <mnet1.1070127696.1558.pinotj@club-internet.fr> <Pine.LNX.4.58.0312011606200.2733@home.osdl.org> <20031202013716.GG621@frodo> <20031202064418.GA2312@frodo> <20031202180540.GR1566@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031202180540.GR1566@mis-mike-wstn.matchmail.com>; from mfedyk@matchmail.com on Tue, Dec 02, 2003 at 10:05:40AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 10:05:40AM -0800, Mike Fedyk wrote:
> On Tue, Dec 02, 2003 at 05:44:18PM +1100, Nathan Scott wrote:
> > I'm not seeing anything to suggest random slab corruption, and I'm
> > so far unable to trip things up as easily as you're able to Jerome.
> > Do you have just a very small amount of memory perhaps?  I can try
> > running while very low on memory, but thats the only other obvious
> > thing I can think of atm.
> 
> How about XFS on DM on RAID?

I didn't see references to those in Jeromes original description,
so haven't been testing those in this context.  But I need to do
more testing on those subsystems anyway, so, will do.

cheers.

-- 
Nathan
