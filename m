Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264645AbTDZK3h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 06:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbTDZK3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 06:29:37 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40202 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264645AbTDZK3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 06:29:33 -0400
Date: Sat, 26 Apr 2003 06:36:13 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ben Collins <bcollins@debian.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
In-Reply-To: <20030425181610.GA2774@phunnypharm.org>
Message-ID: <Pine.LNX.3.96.1030426063455.20200B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003, Ben Collins wrote:

> > Yes, and I miss why that matters. Let me see if I can make the idea clear
> > to you:
> >   2.4.22-pre5		some code
> >   2.4.22-pre5-bk1	fixes
> >   2.4.22-pre5-bk2	more fixes
> >   2.4.22-pre5-bk3	still more fixes
> >   2.4.22-pre6		fixes to date plus major changes
> > 
> > So when a maintainer got something major it wouldn't go into bk (the
> > commercial software database) until a new -pre, while the -bk patches
> > available for download would get the fixes only.
> 
> What if a fix depends on a major-change-patch? What if a fix is itself a
> major change?

Time for a -pre. That's a change management decision. Hopefully -pre would
be somewhat closer spaced than has happened with 2.4.21.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

