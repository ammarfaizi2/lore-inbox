Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310426AbSCGRbE>; Thu, 7 Mar 2002 12:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310425AbSCGRa7>; Thu, 7 Mar 2002 12:30:59 -0500
Received: from mark.mielke.cc ([216.209.85.42]:32781 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S310426AbSCGRap>;
	Thu, 7 Mar 2002 12:30:45 -0500
Date: Thu, 7 Mar 2002 12:26:40 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020307122640.A813@mark.mielke.cc>
In-Reply-To: <Pine.GSO.4.21.0203061424190.14695-100000@vervain.sonytel.be> <Pine.LNX.4.21.0203061525160.6899-100000@serv> <20020306090011.G15303@work.bitmover.com> <a685rc$v4$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a685rc$v4$1@forge.intermeta.de>; from hps@intermeta.de on Thu, Mar 07, 2002 at 04:51:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 04:51:56PM +0000, Henning P. Schmiedehausen wrote:
> Larry McVoy <lm@bitmover.com> writes:
> >	# extract all the patches from 2.5.0 onward.
> >	bk prs -hrv2.5.0.. |  while read x
> >	do	bk export -tpatch -r$i > ~ftp/patches/patch-$i
> >	done
> [henning@henning henning]$ bk prs -hrv2.5.0.. |  while read x
> while: Expression Syntax.
> You obviously just _underlined_ the point, Larry.
> ...
> It's tcsh; before you ask.

If you know that the above works only with [zk(ba)]sh, I don't know
what point you would be making by stating that it doesn't work with
tcsh. Put it in a script, and put #!/bin/bash on the top. Now wasn't
that fun?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

