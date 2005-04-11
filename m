Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVDKHpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVDKHpv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 03:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVDKHpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 03:45:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57272 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261722AbVDKHpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 03:45:41 -0400
Date: Mon, 11 Apr 2005 09:45:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Baudis <pasky@ucw.cz>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
Message-ID: <20050411074523.GB5485@elte.hu>
References: <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org> <20050410222737.GC5902@pasky.ji.cz> <Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org> <20050410232637.GC18661@pasky.ji.cz> <Pine.LNX.4.58.0504101639130.1267@ppc970.osdl.org> <20050410235617.GE18661@pasky.ji.cz> <Pine.LNX.4.58.0504101716420.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101716420.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Btw, does anybody have strong opinions on the license? I didn't put in 
> a COPYING file exactly because I was torn between GPLv2 and OSL2.1.
> 
> I'm inclined to go with GPLv2 just because it's the most common one, 
> but I was wondering if anybody really had strong opinions. For 
> example, I'd really make it "v2 by default" like the kernel, since I'm 
> sure v3 will be fine, but regardless of how sure I am, I'm _not_ a 
> gambling man.

is there any fundamental problem with going with v2 right now, and then 
once v3 is out and assuming it looks ok, all newly copyrightable bits 
(new files, rewrites, substantial contributions, etc.) get a v3 
copyright? (and the collection itself would be v3 too) That method 
wouldnt make it fully v3 automatically once v3 is out, but with time 
there would be enough v3 bits in it to make it essentially v3. This way 
we wouldnt have to blanket trust v3 before having seen it, and wouldnt 
be stuck at v2 either.

	Ingo
