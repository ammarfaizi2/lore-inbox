Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314913AbSDVXMu>; Mon, 22 Apr 2002 19:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314926AbSDVXMt>; Mon, 22 Apr 2002 19:12:49 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1350 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314913AbSDVXMr>; Mon, 22 Apr 2002 19:12:47 -0400
Date: Mon, 22 Apr 2002 19:12:47 -0400
From: Doug Ledford <dledford@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andreas Dilger <adilger@clusterfs.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFF TOPIC] BK license change
Message-ID: <20020422191247.H914@redhat.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Andreas Dilger <adilger@clusterfs.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020421095715.A10525@work.bitmover.com> <E16zPbZ-0001NE-00@starship> <20020422222922.GM3017@turbolinux.com> <E16zQCP-0001NN-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 12:52:48AM +0200, Daniel Phillips wrote:
> Larry's proposing to turn BitKeeper into an automated GPL enforcement machine, 
> even poking it's nose into areas the GPL isn't concerned about.  This is a
> horribly broken reason for adding let more t&c's do the license.

You didn't read Larry's initial email very close.  He isn't trying to turn 
BK into a GPL enforcing machine, he's trying to turn BK into a BK License 
enforcing machine.  Larry lets certain people (such as linux kernel 
hackers) use BK for free.  He does that specifically for contributors 
to open source projects.  Some people are, in essence, signing up to use 
the software as though they are working on open source projects but they 
are never actually open sourcing their work (or are intentionally 
obfuscating parts of it).  Since that violates the spirit of what Larry is 
trying to do by letting people use BK in a non-commercial manner, he is 
trying to find appropriate wording and possibly algorithms that can be put 
into BK to enforce the original spirit of the free use license that BK 
allows certain people.  So, he's not poking his nose into the GPL, he's 
trying to find a way to make sure that people who claim to be using BK on 
GPL projects (and free of charge as a result) are actually doing so.  
That's perfectly within his rights as owner of BK.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
