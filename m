Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVDZUo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVDZUo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVDZUoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:44:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19600 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261660AbVDZUn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:43:58 -0400
Date: Tue, 26 Apr 2005 22:43:57 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Philip Pokorny <ppokorny@mindspring.com>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Message-ID: <20050426204357.GN13224@pasky.ji.cz>
References: <20050426032422.GQ13467@pasky.ji.cz> <426DE78A.3050508@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426DE78A.3050508@mindspring.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 09:02:34AM CEST, I got a letter
where Philip Pokorny <ppokorny@mindspring.com> told me that...
> Petr Baudis wrote:
> 
> >the history changed again (hopefully the
> >last time?) because of fixing dates of some old commits.
> >
> 
> Looks like the git-pasky-0.7 tags (and friends) are now dead links. For 
> example:
> 
> [philip@xray cogito]$ cg-mkpatch git-pasky-0.7:HEAD
> .git/objects/c8/3b95297c2a6336c2007548f909769e0862b509: No such file or 
> directory
> fatal: cat-file c83b95297c2a6336c2007548f909769e0862b509: bad file
> Invalid id: c83b95297c2a6336c2007548f909769e0862b509

Oops. Good catch, fixed. I actually just iterated cg-log. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
