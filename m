Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWBGApL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWBGApL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWBGApK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:45:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28045 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964899AbWBGApJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:45:09 -0500
Date: Tue, 7 Feb 2006 01:44:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bojan Smojver <bojan@rexursive.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <nigel@suspend2.net>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207004448.GC1575@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139251682.2791.290.camel@mindpipe> <200602070625.49479.nigel@suspend2.net> <200602070051.41448.rjw@sisk.pl> <20060207113159.nyjixl5eokookcsw@imp.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207113159.nyjixl5eokookcsw@imp.rexursive.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are you Max Dubois, second incarnation or what?

> Well, given that the kernel suspend is going to be kept for a while, 
> wouldn't it be better if it was feature full? How would the users be at 
                                                ~~~~~~~~~~~~~~~~~~~~~~~~~
> a disadvantage if they had better kernel based suspend for a while, 
~~~~~~~~~~~~~~~~
> followed by u-beaut-cooks-cleans-and-washes uswsusp? That's the part I 
> don't get...

*Users* would not be at disadvantage, but, surprise, there's one thing
more important than users. Thats developers, and I can guarantee you
that merging 14K lines of code just to delete them half a year later
would drive them crazy.

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
