Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVDKA1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVDKA1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 20:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVDKA1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 20:27:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40929 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261646AbVDKA1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 20:27:08 -0400
Date: Mon, 11 Apr 2005 02:27:06 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
Message-ID: <20050411002706.GF18661@pasky.ji.cz>
References: <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org> <20050410222737.GC5902@pasky.ji.cz> <Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org> <20050410232637.GC18661@pasky.ji.cz> <Pine.LNX.4.58.0504101639130.1267@ppc970.osdl.org> <20050410235617.GE18661@pasky.ji.cz> <Pine.LNX.4.58.0504101716420.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101716420.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 11, 2005 at 02:20:52AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Btw, does anybody have strong opinions on the license? I didn't put in a 
> COPYING file exactly because I was torn between GPLv2 and OSL2.1.
> 
> I'm inclined to go with GPLv2 just because it's the most common one, but I 
> was wondering if anybody really had strong opinions. For example, I'd 
> really make it "v2 by default" like the kernel, since I'm sure v3 will be 
> fine, but regardless of how sure I am, I'm _not_ a gambling man.

Oh, I wanted to ask about this too. I'd mostly prefer GPLv2 (I have no
problem with the version restriction, I usually do it too), it's the one
I'm mostly familiar with and OSL appears to be incompatible with GPL (at
least FSF says so about OSL1.0), which might create various annoying
issues. I hate when licenses get in my way and prevent me to possibly
include some useful code.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
