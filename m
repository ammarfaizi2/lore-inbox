Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVDKKUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVDKKUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVDKKUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:20:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37098 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261762AbVDKKRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:17:09 -0400
Date: Mon, 11 Apr 2005 12:17:08 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: [ANNOUNCE] git-pasky-0.2
Message-ID: <20050411101708.GB25538@pasky.ji.cz>
References: <20050411015852.GI5902@pasky.ji.cz> <Pine.LNX.4.21.0504102236220.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504102236220.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 11, 2005 at 04:46:42AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Mon, 11 Apr 2005, Petr Baudis wrote:
> 
> >   Hello,
> > 
> >   here goes git-pasky-0.2, my set of patches and scripts upon
> > Linus' git, aimed at human usability and to an extent a SCM-like usage.
> 
> Incidentally, the git-pasky-base tarball you have up has its checked-out
> tree partway between 0.1 and 0.2, and doesn't compile. (The included HEAD
> version in .dircache is fine, if the user has some way to bootstrap)

Oops, I'm sorry. It appears some diffs just slipped out from the tracked
tree, perhaps I was pulling once when git diff was broken and I didn't
notice it. Now there is a newer tarball there, it is not a pure 0.2
anymore though - if you use the COMMITTER_* env variables, they are now
AUTHOR_*.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
