Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266176AbUHORCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUHORCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUHORCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:02:30 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:7831 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266176AbUHORC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:02:28 -0400
Date: Sun, 15 Aug 2004 19:02:28 +0200
From: Martin Mares <mj@ucw.cz>
To: Sindi Keesan <keesan@iamjlamb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mdacon and scroll buffer
Message-ID: <20040815170228.GA25095@ucw.cz>
References: <Pine.LNX.4.44.0408151215040.5391-100000@foxxy.triohost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408151215040.5391-100000@foxxy.triohost.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Mdacon appears to have no Scroll_Backward or _Forward feature (scroll
> buffer) like vgacon does (shift Page Up or shift Page Down).  I use
> mdacon.o with a 2-monitor system.  Is there something in vgacon.c I could
> copy over to mdacon.c so I could try to compile my own version with scroll
> buffer?

On which card do you run mdacon?  Hercules or something MDA-like?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Even nostalgia isn't what it used to be.
