Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270607AbTGNMkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270608AbTGNMiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:38:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55825 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S270607AbTGNMag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:30:36 -0400
Date: Fri, 4 Jan 2002 12:32:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, Andrew Morton <akpm@digeo.com>,
       Daniel Phillips <phillips@arcor.de>, acme@conectiva.com.br, cw@f00f.org,
       torvalds@transmeta.com, geert@linux-m68k.org, alan@lxorguk.ukuu.org.uk,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Message-ID: <20020104113205.GB1778@zaurus.ucw.cz>
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <20030622014345.GD10801@conectiva.com.br> <20030621191705.3c1dbb16.akpm@digeo.com> <200306221522.29653.phillips@arcor.de> <20030622103251.158691c3.akpm@digeo.com> <20030623010555.GA4302@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623010555.GA4302@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If you think 3.[23] are slow, go back and compile with 2.7.2 - it's much 
> faster than the later versions.  I used to yank newer versions of gcc 
> off systems and put 2.7.2 on, I think it was close to 2x faster at 
> compilation and made no difference on BK performance.

Perhaps someone schould create 2.7.3 with long long bugs fixed
and with c99 initializers?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

