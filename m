Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992523AbWJTGhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992523AbWJTGhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992521AbWJTGhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:37:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:984 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992523AbWJTGhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:37:16 -0400
Date: Thu, 19 Oct 2006 23:37:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
Message-Id: <20061019233708.3b1f4811.akpm@osdl.org>
In-Reply-To: <45386C29.7050501@drzeus.cx>
References: <4537EB67.8030208@drzeus.cx>
	<20061019152503.217a82aa.akpm@osdl.org>
	<45386C29.7050501@drzeus.cx>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 08:26:49 +0200
Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> Andrew Morton wrote:
> > Just send me the url&branch-name for a tree which you want included in -mm.
> > I typically pull all the trees once per day.  I usually won't even look at
> > the contents of what I pulled from you unless it breaks.
> >
> > IOW, -mm is like a tree to which 70-odd people have commit permissions,
> > except it's 70 separate trees and I independently jam them all into one
> > tree daily.
> >   
> 
> So, in other words, you have no issues with a lot of merges in the
> branch you're pulling from? Do you do a fresh pull each time or do you
> update an existing copy? If you do the latter, then I assume it is
> critical that my "for-andrew" branch has a continous history? (Which it
> won't naturally have as the changes will be replaced by identical
> changes coming from Linus' tree)
> 

I don't care what the history is.  I fetch the whole thing then generate
(you - linus) as a single unified diff then whack it into the patch pile.

