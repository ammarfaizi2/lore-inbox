Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUBVKfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 05:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbUBVKfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 05:35:39 -0500
Received: from gate.in-addr.de ([212.8.193.158]:2212 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261221AbUBVKfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 05:35:38 -0500
Date: Sun, 22 Feb 2004 11:37:31 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GFS requirements (was: Non-GPL export of invalidate_mmap_range)
Message-ID: <20040222103731.GA19437@marowsky-bree.de>
References: <20040216190927.GA2969@us.ibm.com> <200402202216.09908.phillips@arcor.de> <20040221141724.GH6280@marowsky-bree.de> <200402211409.13203.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200402211409.13203.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-02-21T14:09:13,
   Daniel Phillips <phillips@arcor.de> said:

> But the one true clustering infrastructure hasn't been developed yet. 

Yes.

> from being able to define that sensibly now.  It's better to implement 
> exactly what a given DFS needs for the time being.

Right.

> > So, how does OpenGFS/GFS achieve the communication? How does it
> > interact with the infrastructure (which, I infere from your above
> > comments, is meant to reside in user-space)?
> It's done both ways, actually.  No new kernel hooks are used in either
> case.

That doesn't answer my question how you are doing the user-space /
kernel communication ;-)

And will the user-space infrastructure to go with GFS be open source
too? Questions over questions.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

