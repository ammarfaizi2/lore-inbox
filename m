Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWA3U6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWA3U6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWA3U6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:58:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51334 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964981AbWA3U6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:58:08 -0500
Date: Mon, 30 Jan 2006 12:57:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: xslaby@fi.muni.cz, marc@osknowledge.org, linux-kernel@vger.kernel.org
Subject: Re: -git tree? (was Re: 2.6.16-rc1-mm4)
Message-Id: <20060130125740.32b2d6da.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0601300746490.17839@shark.he.net>
References: <20060130141318.31F5622AEE6@anxur.fi.muni.cz>
	<Pine.LNX.4.58.0601300746490.17839@shark.he.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> On Mon, 30 Jan 2006, Jiri Slaby wrote:
> 
> > Jiri Slaby wrote:
> > >Marc Koschewski wrote:
> > >>Andrew,
> > >>
> > >>	as already asked a couple of weeks ago: do we have a chance to be able
> > >>to checkout the -mm tree with git someday? It would be very convenient. ;)
> > >Search archive (a week or 2)...
> > Ignore me.
> 
> Matthias Urlichs did import 2.6.15-mm3 into a git:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113726055823770&w=2
> 

I've asked Matthias for a copy of his scripts, but there's some bug still
to be fixed, apparently.  quitl2git is an option too.

Basically I need some script which just does it all and then shoves it
at kernel.org, but getting into another big fight with git doesn't appeal a
lot right now.
