Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTLBSIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTLBSH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:07:56 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59149
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262725AbTLBSGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:06:05 -0500
Date: Tue, 2 Dec 2003 10:05:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, pinotj@club-internet.fr,
       manfred@colorfullife.com, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031202180540.GR1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	Linus Torvalds <torvalds@osdl.org>, pinotj@club-internet.fr,
	manfred@colorfullife.com, Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <mnet1.1070127696.1558.pinotj@club-internet.fr> <Pine.LNX.4.58.0312011606200.2733@home.osdl.org> <20031202013716.GG621@frodo> <20031202064418.GA2312@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202064418.GA2312@frodo>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 05:44:18PM +1100, Nathan Scott wrote:
> I'm not seeing anything to suggest random slab corruption, and I'm
> so far unable to trip things up as easily as you're able to Jerome.
> Do you have just a very small amount of memory perhaps?  I can try
> running while very low on memory, but thats the only other obvious
> thing I can think of atm.

How about XFS on DM on RAID?
