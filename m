Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291857AbSBARMp>; Fri, 1 Feb 2002 12:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291864AbSBARMg>; Fri, 1 Feb 2002 12:12:36 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:10133 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S291857AbSBARMY>; Fri, 1 Feb 2002 12:12:24 -0500
Date: Fri, 01 Feb 2002 12:12:11 -0500 (EST)
Message-Id: <20020201.121211.55941171.wscott@bitmover.com>
To: lm@bitmover.com
Cc: brand@jupiter.cs.uni-dortmund.de, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
From: Wayne Scott <wscott@bitmover.com>
In-Reply-To: <20020201083855.C8664@work.bitmover.com>
In-Reply-To: <lm@bitmover.com>
	<200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de>
	<20020201083855.C8664@work.bitmover.com>
X-Mailer: Mew version 2.1.52 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry McVoy <lm@bitmover.com>
> If so, what you are describing is called "hacking" in the negative
> sense of the word, and what my customers do is called "programming".
> It's quite rare to see the sort of mess that you described, it happens,
> but it is rare.  I don'tknow how else to explain it, but it is not the
> norm in the professional world to try a zillion different approaches
> and revision control each and every one.
> 
> The norm is:
> 	clone a repository
> 	edit the files
> 	modify/compile/debug until it works
> 	check in
> 	push the patch up the shared repository

Or they create do a line of development in a repository with commits
and then determine that it wasn't working.  No problem throw it away
and start over from a clean copy.  Since the repositories are
distributed, private branches just disappear if you don't like them.

-Wayne
