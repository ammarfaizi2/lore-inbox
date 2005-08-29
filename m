Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVH2OnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVH2OnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 10:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbVH2OnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 10:43:03 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:45563 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750787AbVH2OnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 10:43:02 -0400
Subject: Re: Linux 2.6.13
From: Steven Rostedt <rostedt@goodmis.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: ncunningham@cyclades.com, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43131AE9.7010802@gmail.com>
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>
	 <1125313050.5611.11.camel@localhost.localdomain>
	 <1125317850.6496.7.camel@localhost>  <43131AE9.7010802@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 29 Aug 2005 10:42:49 -0400
Message-Id: <1125326569.5611.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 22:25 +0800, Antonino A. Daplas wrote:
> Nigel Cunningham wrote:
> > Hi.
> > 
> > On Mon, 2005-08-29 at 20:57, Steven Rostedt wrote:
> >> On Sun, 2005-08-28 at 17:17 -0700, Linus Torvalds wrote:
> >>
> >>> Paul Mackerras:
> >>>   Remove race between con_open and con_close
> >> Hey, I'm the first to report this with the fix and Paul gets the credit?
> >> I guess I'll crawl back to my little world (RT) where they actually
> >> appreciate me. :-(
> > 
> > Did you report it or fix it? :>
> > 
> 
> Both, actually, with exactly the same patch.  In the long changelog, both 
> Steven and Paul are co-signees but only Paul's name appeared in the short 
> changelog.
> 
> Tony

Thanks Tony, but I'm not really upset.  My main focus _is_ on what
Ingo's doing in the RT world.  I just thought it was amusing that the
one who supplied the patch second got the credit. If it was the other
way around, and Paul was the first to supply the patch and my name
appeared, I would have made a crack at that too. :-)

-- Steve


