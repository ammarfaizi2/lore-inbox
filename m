Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSFSRLh>; Wed, 19 Jun 2002 13:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSFSRLg>; Wed, 19 Jun 2002 13:11:36 -0400
Received: from ns.suse.de ([213.95.15.193]:34820 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317945AbSFSRLg>;
	Wed, 19 Jun 2002 13:11:36 -0400
Date: Wed, 19 Jun 2002 19:11:36 +0200
From: Dave Jones <davej@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>,
       rwhron@earthlink.net
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Message-ID: <20020619191136.H29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>,
	rwhron@earthlink.net
References: <Pine.LNX.4.44.0206181340380.3031-100000@loke.as.arizona.edu> <E17KipF-0000up-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17KipF-0000up-00@starship>; from phillips@bonn-fries.net on Wed, Jun 19, 2002 at 07:00:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 07:00:57PM +0200, Daniel Phillips wrote:
 > > ...Hope this is of use to someone!  It's certainly been a fun and 
 > > instructive exercise for me so far.  ;)
 > It's intensely useful.  It changes the whole character of the VM discussion 
 > at the upcoming kernel summit from 'should we port rmap to mainline?' to 'how 
 > well does it work' and 'what problems need fixing'.  Much more useful.

Absolutely.  Maybe Randy Hron (added to Cc) can find some spare time
to benchmark these sometime before the summit too[1]. It'll be very
interesting to see where it fits in with the other benchmark results
he's collected on varying workloads.

        Dave

[1] I am master of subtle hints.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
