Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbTEHC0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 22:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTEHC0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 22:26:16 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:60679 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261199AbTEHC0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 22:26:15 -0400
Date: Wed, 7 May 2003 22:36:42 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
cc: Pavel Machek <pavel@ucw.cz>, John Levon <levon@movementarian.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: bkcvs not up-to-date?
In-Reply-To: <3EB9ACE1.405@gmx.net>
Message-ID: <Pine.LNX.4.10.10305072233360.15498-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003, Carl-Daniel Hailfinger wrote:
> 
> Pavel Machek wrote:
> > 
> >>>and checked out the tree, but cvs log Makefile still indicates 2.5.68
> >>>is the lastest version. What am I doing wrong?
> >>
> >>I have the same problem, the CVS gateway got stuck some point in the
> >>middle of 2.5.68 and has had no apparen t updates since
> > 
> > 
> > Its even worse: part of updates gets there. Like CREDITS file is
> > up-to-date but Makefile is not.

Yeah, I'm getting errors trying to load loop.ko, that looks kind of
suspicious...loop has been working...of course I guess it could be the
regularly scheduled breakage...

--
Paul

