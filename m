Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVITVhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVITVhn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVITVhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:37:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54699 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750743AbVITVhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:37:43 -0400
Date: Tue, 20 Sep 2005 23:37:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roman I Khimov <rik@osrc.info>
Cc: reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050920213728.GA1945@elf.ucw.cz>
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz> <200509202328.28501.rik@osrc.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509202328.28501.rik@osrc.info>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can V4 survive few hours of test below?
> 
> Maybe I'm doing something wrong here, but ext2 have failed on second check 
> of first pass with

No, you have probably just found bug in e2fsck...

> Second check...
> e2fsck 1.34 (25-Jul-2003)

I have 1.38 here, so yours is too old.

OTOH if reiser4 survives that for 80 cycles... that's pretty good.

									Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
