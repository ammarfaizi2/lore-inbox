Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbSLPRR7>; Mon, 16 Dec 2002 12:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbSLPRQ7>; Mon, 16 Dec 2002 12:16:59 -0500
Received: from bitmover.com ([192.132.92.2]:19861 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266888AbSLPRQW>;
	Mon, 16 Dec 2002 12:16:22 -0500
Date: Mon, 16 Dec 2002 09:24:15 -0800
From: Larry McVoy <lm@bitmover.com>
To: Dave Jones <davej@codemonkey.org.uk>, Ben Collins <bcollins@debian.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Notification hooks
Message-ID: <20021216092415.E432@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Ben Collins <bcollins@debian.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
References: <20021216171218.GV504@hopper.phunnypharm.org> <20021216171925.GC15256@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021216171925.GC15256@suse.de>; from davej@codemonkey.org.uk on Mon, Dec 16, 2002 at 05:19:25PM +0000
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 05:19:25PM +0000, Dave Jones wrote:
> On Mon, Dec 16, 2002 at 12:12:18PM -0500, Ben Collins wrote:
>  > Linus, is there anyway I can request a hook so that anything that
>  > changes drivers/ieee1394/ in your repo sends me an email with the diff
>  > for just the files in that directory, and the changeset log? Is this
>  > something that bkbits can do?
>  > 
>  > I'd bet lots of ppl would like similar hooks for their portions of the
>  > source.
> 
> It'd be nice if the bkbits webpage had a "notify me" interface for files
> in Linus' repository. This way not just the maintainers, but folks
> interested in changes in that area can also see the changes.

Just for linux.bkbits.net or for the openlogging tree?  To remind people, 
linux.bkbits.net has Linus/Marcelo trees but openlogging.org has the 
union of all trees anywhere in the world.  And openlogging doesn't have
contents, it just has comments.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
