Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUBYW2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUBYWZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:25:55 -0500
Received: from gprs151-5.eurotel.cz ([160.218.151.5]:13956 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261757AbUBYWYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:24:44 -0500
Date: Wed, 25 Feb 2004 23:24:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
Subject: Re: 3/3 kgdb over netpoll
Message-ID: <20040225222423.GJ1307@elf.ucw.cz>
References: <20040222160849.GA9563@elf.ucw.cz> <20040225215240.GE3883@waste.org> <20040225221246.GH1307@elf.ucw.cz> <20040225221719.GF3883@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225221719.GF3883@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Feb 25, 2004 at 11:12:46PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > This is kgdb-over-ethernet patch. Depends on netpoll, and is somehow
> > > > experimental.
> > > 
> > > Please pick up the current kgdboe docs from -mm.
> > 
> > I'll try to get some docs there, unfortunately this uses completely
> > different command line format, so it is not matter of simple copy.
> 
> Uh, it's based on netpoll but doesn't use the netpoll parser?!

Oops, sorry, you are right. 
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
