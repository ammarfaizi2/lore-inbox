Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSLHViB>; Sun, 8 Dec 2002 16:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSLHViB>; Sun, 8 Dec 2002 16:38:01 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261642AbSLHViB>;
	Sun, 8 Dec 2002 16:38:01 -0500
Date: Fri, 6 Dec 2002 10:02:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021206090234.GA1940@zaurus>
References: <9633612287A@vcnet.vc.cvut.cz> <aslmtl_im_1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aslmtl_im_1@cesium.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > And because of I was not able to find anything in POSIX which would say
> > that we should do split on spaces (not that I found that we should not), 
> > I vote for leaving current behavior in Linux, and fixing perl manpage 
> > (and eventually FreeBSD, if anyone is interested) instead.
> > 
> 
> Classic catch-22: POSIX won't standardize it because of lack of
> consistency between UNIX implementations, although everyone pretty
> much agrees it would be a desirable feature to add to the standard.

Why can't we simply have /bin/bash_that_splits_args_itself
?
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

