Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTDYSTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbTDYSTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:19:07 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:18829 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263635AbTDYSTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:19:06 -0400
Date: Fri, 25 Apr 2003 14:16:10 -0400
From: Ben Collins <bcollins@debian.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030425181610.GA2774@phunnypharm.org>
References: <20030424214107.GH808@phunnypharm.org> <Pine.LNX.3.96.1030425135740.16623D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030425135740.16623D-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, and I miss why that matters. Let me see if I can make the idea clear
> to you:
>   2.4.22-pre5		some code
>   2.4.22-pre5-bk1	fixes
>   2.4.22-pre5-bk2	more fixes
>   2.4.22-pre5-bk3	still more fixes
>   2.4.22-pre6		fixes to date plus major changes
> 
> So when a maintainer got something major it wouldn't go into bk (the
> commercial software database) until a new -pre, while the -bk patches
> available for download would get the fixes only.

What if a fix depends on a major-change-patch? What if a fix is itself a
major change?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
