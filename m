Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVBJJx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVBJJx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 04:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVBJJx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 04:53:57 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:6536 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262087AbVBJJwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 04:52:42 -0500
Date: Thu, 10 Feb 2005 10:52:19 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
       tytso@mit.edu, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
In-Reply-To: <20050210005041.GA26312@bitmover.com>
Message-ID: <Pine.LNX.4.61.0502101045110.30794@scrub.home>
References: <20050209184629.GR22893@bitmover.com>
 <Pine.LNX.4.61.0502091513060.7836@localhost.localdomain>
 <20050209235312.GA25351@bitmover.com> <Pine.LNX.4.61.0502100109050.6118@scrub.home>
 <20050210005041.GA26312@bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Feb 2005, Larry McVoy wrote:

> This problem is nowhere near as hard as you are making it out to be
> but it is hard.  But it's not that bad, we do this every time we do
> a CVS import, we have to intuit the changeset boundaries themselves,
> which is actually harder than what you are trying to do.  Think about
> taking revision history without any changeset grouping and recreating
> the changesets (aka patches).  We do that all the time, automatically.
> If we can do that then you can do this.

That's simply not true and you know that.
I repeat, the bkweb information is not enough to recreate the history, 
incomplete data will only produce incomplete results no matter how hard 
you try and I delivered the _proof_ for that.

bye, Roman
