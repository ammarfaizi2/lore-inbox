Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314032AbSDFG7p>; Sat, 6 Apr 2002 01:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314033AbSDFG7f>; Sat, 6 Apr 2002 01:59:35 -0500
Received: from bitmover.com ([192.132.92.2]:25554 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314032AbSDFG71>;
	Sat, 6 Apr 2002 01:59:27 -0500
Date: Fri, 5 Apr 2002 22:59:25 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.8-pre2
Message-ID: <20020405225925.D6087@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 05:01:31PM -0800, Linus Torvalds wrote:
> 
> More merging with various people, USB+ARM+more network drivers etc.
> 
> The actual patch is pretty huge, because the USB changes moves USB files
> around a lot. The BK diffs (and actual "real changes") are smaller than 
> the patch would imply (here Larry pipes up with number of deltas ;)

Here ya go.  

    takepatch: 991 new revisions, 0 conflicts in 578 files
    206734 bytes uncompressed to 954854, 4.62X expansion
    Running resolve to apply new work ...
    Using lm.bitmover.com:0 as graphical display
    Verifying consistency of the RESYNC tree...
    resolve: found 103 renames in pass 1
    resolve: resolved 103 renames in pass 2
    resolve: applied 578 files in pass 4

I love how much people move around files when the SCM system actually handles
it properly.  I used to worry that people who were trained to not move files
by CVS would never figure out that BK handles it; I was wrong and glad of it :)
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
