Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbSLPRPi>; Mon, 16 Dec 2002 12:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbSLPRPi>; Mon, 16 Dec 2002 12:15:38 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:38151 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S266876AbSLPRPh>; Mon, 16 Dec 2002 12:15:37 -0500
Date: Mon, 16 Dec 2002 12:23:30 -0500
From: Ben Collins <bcollins@debian.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Notification hooks
Message-ID: <20021216172330.GW504@hopper.phunnypharm.org>
References: <20021216171218.GV504@hopper.phunnypharm.org> <20021216171925.GC15256@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216171925.GC15256@suse.de>
User-Agent: Mutt/1.4i
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
> 
> As well as opening this up for more people, it'd also take the load
> of Linus having to do it.

True. But if the load is too much for bkbits to handle, I'd like Linus
to consider it just for maintainers.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
