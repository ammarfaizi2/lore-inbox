Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUJ0Dyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUJ0Dyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUJ0Dyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:54:33 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:9625 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261443AbUJ0DyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:54:24 -0400
Date: Tue, 26 Oct 2004 20:54:12 -0700
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041027035412.GA8493@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com> <Pine.LNX.4.61.0410270338310.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410270338310.877@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman, 

While I respect your position that anything not GPL is evil, without
agreeing with it, that does not in any way extend to anything which
violates our license.

If there is some information that you need as a kernel developer which
BK is hiding from you of course we would provide that information.
To the best of my knowledge there is absolutely nothing that we are
hiding from you in that context.  If there is, let us know.  Our belief
is at least in part based on the lack of queries from anyone else.

On the other hand, if there is information that is not interesting to
a kernel developer but is interesting to someone trying to rip off our
software, no, we must respectfully decline to offer that.

Thanks,

--lm

On Wed, Oct 27, 2004 at 04:30:37AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 25 Oct 2004, Larry McVoy wrote:
> 
> > You are mistakenly assuming that the way BK stores the data, or does
> > merges, or synchronizes is what we think is worth protecting, and you
> > are pretty much wrong.
> 
> Does that mean you don't mind if someones export the changeset information 
> in an useful way? All I need is pretty much the information that already 
> comes via the commit list (actually in the format used until May, where 
> it still contained information about renames) plus some useful identifiers 
> to identify the predecessors of a changeset.
> 
> bye, Roman

-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
