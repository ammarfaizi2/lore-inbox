Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVDKKwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVDKKwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVDKKwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:52:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10475 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261770AbVDKKwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:52:12 -0400
Date: Mon, 11 Apr 2005 12:52:11 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
Message-ID: <20050411105211.GA28484@pasky.ji.cz>
References: <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org> <20050410222737.GC5902@pasky.ji.cz> <Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org> <20050410232637.GC18661@pasky.ji.cz> <Pine.LNX.4.58.0504101639130.1267@ppc970.osdl.org> <20050410235617.GE18661@pasky.ji.cz> <Pine.LNX.4.58.0504101716420.1267@ppc970.osdl.org> <20050411074523.GB5485@elte.hu> <871x9hemfz.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871x9hemfz.fsf@deneb.enyo.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 11, 2005 at 10:40:00AM CEST, I got a letter
where Florian Weimer <fw@deneb.enyo.de> told me that...
> * Ingo Molnar:
> 
> > is there any fundamental problem with going with v2 right now, and then 
> > once v3 is out and assuming it looks ok, all newly copyrightable bits 
> > (new files, rewrites, substantial contributions, etc.) get a v3 
> > copyright? (and the collection itself would be v3 too) That method 
> > wouldnt make it fully v3 automatically once v3 is out, but with time 
> > there would be enough v3 bits in it to make it essentially v3.
> 
> Almost certainly, v3 will be incompatible with v2 because it adds
> further restrictions.  This means that your proposal would result in
> software which is not redistributable by third parties.

Hmm, what would be actually the point in introducing further
restrictions? Anyone who then wants to get around them will just
distribute the software with the "any later version" provision under
GPLv2, and GPLv3 will have no impact expect for new software with "v3 or
any later version" provision. What am I missing?

I've been doing a lot of LKML catching up, and I remember someone
suggesting using GPLv2 (for kernel, but should apply to git too), with a
provision to let someone trusted (Linus) decide when GPLv3 is out
whether you can use GPLv3 for the kernel too. Does it make sense? And is
it even legally doable without sending signed written documents to
Linus' tropical hacienda?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
