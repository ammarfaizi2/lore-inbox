Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992515AbWJTG0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992515AbWJTG0p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992513AbWJTG0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:26:44 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:31633 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S2992512AbWJTG0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:26:44 -0400
Message-ID: <45386C29.7050501@drzeus.cx>
Date: Fri, 20 Oct 2006 08:26:49 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
References: <4537EB67.8030208@drzeus.cx> <20061019152503.217a82aa.akpm@osdl.org>
In-Reply-To: <20061019152503.217a82aa.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Just send me the url&branch-name for a tree which you want included in -mm.
> I typically pull all the trees once per day.  I usually won't even look at
> the contents of what I pulled from you unless it breaks.
>
> IOW, -mm is like a tree to which 70-odd people have commit permissions,
> except it's 70 separate trees and I independently jam them all into one
> tree daily.
>   

So, in other words, you have no issues with a lot of merges in the
branch you're pulling from? Do you do a fresh pull each time or do you
update an existing copy? If you do the latter, then I assume it is
critical that my "for-andrew" branch has a continous history? (Which it
won't naturally have as the changes will be replaced by identical
changes coming from Linus' tree)

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

