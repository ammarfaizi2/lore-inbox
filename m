Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264622AbUEPRsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbUEPRsa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264681AbUEPRs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:48:29 -0400
Received: from wingding.demon.nl ([82.161.27.36]:42116 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S264622AbUEPRsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:48:20 -0400
Date: Sun, 16 May 2004 19:49:23 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040516174923.GA16257@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <200405132232.01484.elenstev@mesatop.com> <Pine.LNX.4.58.0405152147220.25502@ppc970.osdl.org> <20040516052220.GU3044@dualathlon.random> <200405160928.22021.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405160928.22021.elenstev@mesatop.com>
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > An easy way to verify for Steven is to give a quick spin to 2.6.5-aa5
> > and see if it's slow too, that will rule out the anon-vma changes
> > (for completeness: there's a minor race in 2.6.5-aa5 fixed in my current
> > internal tree, I posted the fix to l-k separately, but you can ignore
> > the fix for a simple test, it takes weeks to trigger anyways and you
> > need threads to trigger it and I've never seen threaded version control
> > systems so I doubt BK is threaded).
> 
> I'm getting the linux-2.6.5.tar.bz2 file (already got 2.6.5-aa2) via ppp,
> while running the bk test script on 2.6.6-current and no PREEMPT.
> That takes a while on 56k dialup.  I'll leave all that running while
> I go hiking.

ketchup should get you faster to 2.6.5 vanilla...

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
