Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSHIOwL>; Fri, 9 Aug 2002 10:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSHIOwL>; Fri, 9 Aug 2002 10:52:11 -0400
Received: from bitmover.com ([192.132.92.2]:19894 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313867AbSHIOwL>;
	Fri, 9 Aug 2002 10:52:11 -0400
Date: Fri, 9 Aug 2002 07:55:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Paul Larson <plars@austin.ibm.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: daily 2.5 BK snapshots
Message-ID: <20020809075539.A21935@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Paul Larson <plars@austin.ibm.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0208081703260.2589-100000@duckman.distro.conectiva> <3D52D1C9.9070404@mandrakesoft.com> <1028903778.19435.348.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1028903778.19435.348.camel@plars.austin.ibm.com>; from plars@austin.ibm.com on Fri, Aug 09, 2002 at 09:36:17AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 09:36:17AM -0500, Paul Larson wrote:
> previous day, I have a limited set of Changesets as culprits so it's
> easier for me to find the cause of problems when I do more frequent
> testing like this.  

By the way, if you look at Documentation/BUG-HUNTING which describes how
to do binary search to track down bugs, you'll notice you can now do the 
same thing with BK at a much finer granularity.  It's possible to track
down bugs to the changeset which caused the bug, rather than the release.
Which is what Paul is talking about, but he's talking about doing it over
a small set of csets.  You can do it over a large set of csets as well.
File this away as a thing you can do and if you ever need the details,
contact me and I'll walk you through it if it isn't obvious.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
