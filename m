Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVDKATA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVDKATA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 20:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVDKATA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 20:19:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:5079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261643AbVDKAS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 20:18:58 -0400
Date: Sun, 10 Apr 2005 17:20:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
In-Reply-To: <20050410235617.GE18661@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0504101716420.1267@ppc970.osdl.org>
References: <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu>
 <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu>
 <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
 <20050410222737.GC5902@pasky.ji.cz> <Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org>
 <20050410232637.GC18661@pasky.ji.cz> <Pine.LNX.4.58.0504101639130.1267@ppc970.osdl.org>
 <20050410235617.GE18661@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Btw, does anybody have strong opinions on the license? I didn't put in a 
COPYING file exactly because I was torn between GPLv2 and OSL2.1.

I'm inclined to go with GPLv2 just because it's the most common one, but I 
was wondering if anybody really had strong opinions. For example, I'd 
really make it "v2 by default" like the kernel, since I'm sure v3 will be 
fine, but regardless of how sure I am, I'm _not_ a gambling man.

		Linus
