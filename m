Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbTCQVpq>; Mon, 17 Mar 2003 16:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261777AbTCQVpq>; Mon, 17 Mar 2003 16:45:46 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19206 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261758AbTCQVpp>; Mon, 17 Mar 2003 16:45:45 -0500
Date: Mon, 17 Mar 2003 22:56:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Nicolas Pitre <nico@cam.org>,
       Ben Collins <bcollins@debian.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030317215639.GG15658@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home> <Pine.LNX.4.44.0303162014090.12110-100000@serv> <20030316215219.GX1252@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030316215219.GX1252@dualathlon.random>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If you're still unhappy now that the mainline data is open it means
> you're either a jfs developer (but I assume they're all fine with bk
> since they're just using it, so I doubt this is the case) or your

Actually, fact that "longest path" algorithm may well choose
non-mainline branch because it likes it more worries me a bit.

									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
