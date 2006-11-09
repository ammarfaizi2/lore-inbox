Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754804AbWKIJ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbWKIJ0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbWKIJ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:26:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2481 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754804AbWKIJ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:26:44 -0500
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20061108145150.80ceebf4.akpm@osdl.org>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>
	 <1163024531.3138.406.camel@laptopd505.fenrus.org>
	 <20061108145150.80ceebf4.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 09 Nov 2006 10:26:41 +0100
Message-Id: <1163064401.3138.472.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 14:51 -0800, Andrew Morton wrote:
> On Wed, 08 Nov 2006 23:22:11 +0100
> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > > - A while back, akpm made some statements about being worried that the
> > > 2.6 kernel is getting buggier
> > > (http://news.zdnet.com/2100-3513_22-6069363.html).
> > 
> > and at this years Kernel Summit actual data
> 
> Not true.  70% of surveyed users had hit a new kernel bug. 

70% of surveyed users hit ANY kernel bug. Not "new bugs"
Including "my new wizzbang hardware doesn't work" and "I'll try
something new, oh looky a 4 year old bug" and "this new feature isn't
quite mature yet now that I try it".

One of the things that happened was during early 2.6 udev broke left and
right ABI wise. We've gotten a lot better at that, and that's the kind
of bug that hits a really wide audience.

Statistics can be misleading ... bigtime.
83% of the people also said things were not getting less reliable in
2.6.



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

