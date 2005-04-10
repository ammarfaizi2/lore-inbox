Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVDJWaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVDJWaP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVDJWaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 18:30:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11231 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261621AbVDJWaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 18:30:10 -0400
Date: Mon, 11 Apr 2005 00:30:09 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Christopher Li <lkml@chrisli.org>
Cc: Paul Jackson <pj@engr.sgi.com>, torvalds@osdl.org, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: Re: more git updates..
Message-ID: <20050410223009.GD5902@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410065307.GC13853@64m.dyndns.org> <20050410122352.19890f6d.pj@engr.sgi.com> <20050410184253.GF13853@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410184253.GF13853@64m.dyndns.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Apr 10, 2005 at 08:42:53PM CEST, I got a letter
where Christopher Li <lkml@chrisli.org> told me that...
> I totally agree that odds is really really small.
> That is why it is not worthy to handle the case. People hit that
> can just add a new line or some thing to avoid it, if
> it happen after all.
> 
> It is the little peace of mind to know for sure that did
> not happen. I am just paranoid. 

BTW, I've merged the check to git-pasky some time ago, you can disable
it in the Makefile. It is by default on now, until someone convinces me
it actually affects performance measurably.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
