Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVHDUTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVHDUTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVHDURu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:17:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42630 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262662AbVHDUQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:16:45 -0400
Date: Wed, 3 Aug 2005 13:50:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: Documentation - how to apply patches for various trees
Message-ID: <20050803115002.GC4038@elf.ucw.cz>
References: <200508022332.21380.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508022332.21380.jesper.juhl@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> How to apply the -rc, -git, -mm and the 2.6.x.y (-stable) patches is a quite
> frequently asked question on LKML and elsewhere. 
> Since so many people seem to be confused by this I gathered it ought to be 
> properly documented once and for all so we  a) get more people testing those 
> trees  and  b) get asked this question less often.
> So, I sat down and wrote such a document.
> 
> Below is a patch to add a new file "applying-patches.txt" to Documentation/
> This document describes each of the trees and gives examples on how to apply 
> the various patches.
> 
> Looking forward to your feedback (and possible inclusion).
> 
> I guess this document could also be placed somewhere on kernel.org and linked 
> to from the front page so that people downloading the various patches will 
> have this information available at their fingertips.

Perhaps including ketchup in linux/scripts makes sense? Places for
download slowly change so it needs to be kept up-to-date, and it is
*very* nice to use...

									Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
