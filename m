Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266837AbSLPRMl>; Mon, 16 Dec 2002 12:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbSLPRMl>; Mon, 16 Dec 2002 12:12:41 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:31635 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266837AbSLPRMl>;
	Mon, 16 Dec 2002 12:12:41 -0500
Date: Mon, 16 Dec 2002 17:19:25 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ben Collins <bcollins@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Notification hooks
Message-ID: <20021216171925.GC15256@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ben Collins <bcollins@debian.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
References: <20021216171218.GV504@hopper.phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216171218.GV504@hopper.phunnypharm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 12:12:18PM -0500, Ben Collins wrote:
 > Linus, is there anyway I can request a hook so that anything that
 > changes drivers/ieee1394/ in your repo sends me an email with the diff
 > for just the files in that directory, and the changeset log? Is this
 > something that bkbits can do?
 > 
 > I'd bet lots of ppl would like similar hooks for their portions of the
 > source.

It'd be nice if the bkbits webpage had a "notify me" interface for files
in Linus' repository. This way not just the maintainers, but folks
interested in changes in that area can also see the changes.

As well as opening this up for more people, it'd also take the load
of Linus having to do it.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
