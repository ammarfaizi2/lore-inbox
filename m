Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVDKPtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVDKPtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVDKPtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:49:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:58752 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261813AbVDKPtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:49:39 -0400
Date: Mon, 11 Apr 2005 08:49:31 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: pj@engr.sgi.com, junkio@cox.net, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050411084931.4aaf7ae0.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504101634250.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
	<20050410115055.2a6c26e8.pj@engr.sgi.com>
	<Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
	<20050410161457.2a30099a.pj@engr.sgi.com>
	<Pine.LNX.4.58.0504101634250.1267@ppc970.osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Apr 2005 16:38:00 -0700 (PDT) Linus Torvalds wrote:

| 
| 
| On Sun, 10 Apr 2005, Paul Jackson wrote:
| >
| > Useful explanation - thanks, Linus.
| 
| Hey. You're welcome. Especially when you create good documentation for 
| this thing.
| 
| Because:
| 
| > Is this picture and description accurate:
| 
| [ deleted, but I'll probably try to put it in an explanation file 
|   somewhere ]
| 
| Yes. Excellent.
| 
| > Minor question:
| > 
| >   I must have an old version - I got 'git-0.03', but
| >   it doesn't have 'checkout-cache', and its 'read-tree'
| >   directly writes my working files.
| 
| Yes. Crappy old tree, but it can still read my git.git directory, so you 
| can use it to update to my current source base.

Please go into a little more detail about how to do this step...
that seems to be the most basic concept that I am missing.
i.e., how to find the "latest/current" tree (version/commit)
and check it out (read-tree, checkout-cache, etc.).

Even if I use Pasky's tools, I'd like to understand this step.

| However, from a usability angle, my source-base really has been 
| concentrating _entirely_ on just the plumbing, and if you actually want a 
| faucet or a toilet _conntected_ to the plumbing, you're better off with 
| Pasky's tree, methinks:
| 
| >   How do I get a current version?  Well, one way I see,
| >   and that's to pick up Pasky's:
| >     
| >     http://pasky.or.cz/~pasky/dev/git/git-pasky-base.tar.bz2
| >  
| >   Perhaps that's the best way?
| 
| Indeed. He's got a number of shell scripts etc to automate the boring 
| parts.


---
~Randy
