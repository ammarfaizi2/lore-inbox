Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWBEC5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWBEC5J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 21:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWBEC5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 21:57:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:13211 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030218AbWBEC5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 21:57:08 -0500
Date: Sat, 4 Feb 2006 18:56:46 -0800
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: marc@osknowledge.org, dtor_core@ameritech.net, rlrevell@joe-job.com,
       76306.1226@compuserve.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: Wanted: hotfixes for -mm kernels
Message-Id: <20060204185646.f8e4e53e.pj@sgi.com>
In-Reply-To: <20060204083752.a5c5b058.mbligh@mbligh.org>
References: <200602021502_MC3-1-B772-547@compuserve.com>
	<1138913633.15691.109.camel@mindpipe>
	<d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com>
	<20060203100703.GA5691@stiffy.osknowledge.org>
	<20060204083752.a5c5b058.mbligh@mbligh.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we need a place to put hotfix patches, or do we just need a list of
links to lkml postings to said patches.  Such a list has the advantage
of pointing into the discussion surrounding each such fix, and such a
list has the advantage of not holding so much redundant data (these
patches will be redundant with what was posted on lkml).  Redundant
data out of context goes stale, and is less valuable.

I can imagine someone (not me ;) keeping a wiki web page, listing for
each *-mm and Linus release the particular lkml patch postings that one
needs to pick off to get a build and boot.

Just brainstorming ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
