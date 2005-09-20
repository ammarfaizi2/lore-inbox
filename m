Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbVITWMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbVITWMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVITWMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:12:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65256 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965176AbVITWMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:12:41 -0400
Date: Wed, 21 Sep 2005 00:10:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roman I Khimov <rik@osrc.info>
Cc: reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050920221037.GB1945@elf.ucw.cz>
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <200509202328.28501.rik@osrc.info> <20050920213728.GA1945@elf.ucw.cz> <200509210133.41710.rik@osrc.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200509210133.41710.rik@osrc.info>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Second check...
> > > e2fsck 1.34 (25-Jul-2003)
> > 
> > I have 1.38 here, so yours is too old.
> 
> I'll compile something new tomorrow and try to retest it.
>  
> > OTOH if reiser4 survives that for 80 cycles... that's pretty good.
> 
> Actually 125 before I've got completely tired of HDD noise. :)

At tytso's request... could you put some reiser3 and reiser4
filesystem images inside test data?
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
