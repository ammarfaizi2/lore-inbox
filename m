Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTL1DfK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 22:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbTL1DfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 22:35:10 -0500
Received: from [24.35.117.106] ([24.35.117.106]:34978 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264968AbTL1DfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 22:35:06 -0500
Date: Sat, 27 Dec 2003 22:34:43 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Fixing 2.6.0's broken documentation references
In-Reply-To: <20031227160834.2de6401d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0312272222500.14915@localhost.localdomain>
References: <864qvmjtez.fsf@n-dimensional.de> <20031227160834.2de6401d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Dec 2003, Andrew Morton wrote:

> > 2. Some files have been removed (examples: Configure.help, smp.tex).
> >    Fixing this requires manual rewrite of
> >    a) code comments
> >    b) kbuild help
> >    c) Documentation files
> 
> We can live with that.  If someone cares enough, they'll fix it.

I've submitted patches for exactly some of the issues discussed in this 
email, multiple times.  They've been universally dropped on the floor.  
The last time was around the time of the massive spell-check patch binge.  

I agree that having a documentation maintainer would be a good idea.  Hans 
could volunteer or I could if no one else wants it.  Whoever does it 
though, needs some assurance that patches won't be dropped on the floor.
