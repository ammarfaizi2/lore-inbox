Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268564AbTCAPSE>; Sat, 1 Mar 2003 10:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268565AbTCAPSE>; Sat, 1 Mar 2003 10:18:04 -0500
Received: from bitmover.com ([192.132.92.2]:65187 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S268564AbTCAPSD>;
	Sat, 1 Mar 2003 10:18:03 -0500
Date: Sat, 1 Mar 2003 07:28:20 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: andrea@e-mind.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed BitKeeper clone
Message-ID: <20030301152820.GA24536@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@ucw.cz>, andrea@e-mind.com,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030226200208.GA392@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226200208.GA392@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BitKeeper is a trademark, please don't use the BitKeeper name when
describing BitBucket.  Thanks.

On Wed, Feb 26, 2003 at 09:02:12PM +0100, Pavel Machek wrote:
> Hi!
> 
> I've created little project for read-only (for now ;-) bitkeeper
> clone. It is available at www.sf.net/projects/bitbucket (no tar balls,
> just get it fresh from CVS).
> 
> Part of readme follows.
> 
> 
> Install CSSC from <http://cssc.sf.net/> (it is also available as
> Debian package). You may need to apply cssc.diff.
> 
> Here you get following tools:
> 
> bcheckout_HEAD:
>         extracts files from BK repository. You can get repository
>         by rsync -zav --delete nl.linux.org::kernel/linux-2.5 .
> 
> bpull:
>         pull new version of repository, compute differences from
>         the last time and apply them to directory with *your*
>         sources.
> 
> bdiff:
>         compare two versions (specify versions from top-level
>         s.ChangeSet)
> 
> To get a list of all changesets, do prs linux-2.5/SCCS/s.ChangeSet.
> 
> Enjoy, and help me make it usefull,
> 								Pavel
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
