Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263137AbVBCQpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbVBCQpI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVBCQpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:45:08 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:14746 "EHLO
	postbox.bitmover.com") by vger.kernel.org with ESMTP
	id S263680AbVBCQlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:41:10 -0500
Date: Wed, 2 Feb 2005 19:34:59 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050203033459.GA29409@bitmover.com>
Mail-Followup-To: lm@bitmover.com, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <200502030028.j130SNU9004640@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502030028.j130SNU9004640@terminus.zytor.com>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Thanks for the forward, Peter, I would have missed this).

Intel has very kindly donated one of their high end boxes and that's
what is running bkbits.net these days.  We could run the exporter there
pretty much as often as you want.  Send some love to Intel, this box is
way more stable than the previous bkbits.net.  Len Brown made it happen.

As Peter said, we do exports from Linus' tree every 24 hours.  I can
think of two things that we could do which might be useful to the non BK
users: export more frequently (pretty questionable in my mind but it's
no big deal to bump it up to twice or whatever) and/or export other trees
(far more interesting in my mind).

We can always use more hardware if someone is looking to donate but
we can also afford to buy what we need.  Our biggest ongoing cost in
supporting you these days is our internet connection, that's running
about $11K/year for the portion that is exclusively yours.  Fear not,
we get marketing value from providing that so it's no problem, we'll
keep doing it.  A question though, is anyone feeling like we need to
allocate more bandwidth or is that enough?  You guys currently keep a
T1 line pretty much filled 24x7, we can add another one or bump it up
to a T3 if really need to do so.

We're always looking for more ways to help you (or more properly said:
more ways to be perceived as helping) so let us know what you would like.
In Bk or out of it.  Is BK/Web good enough?  Need something?  Let us
know.

Cheers,

--lm


On Wed, Feb 02, 2005 at 04:28:23PM -0800, H. Peter Anvin wrote:
> Followup to:  <20050202155403.GE3117@crusoe.alcove-fr>
> By author:    Stelian Pop <stelian@popies.net>
> In newsgroup: linux.dev.kernel
> >
> > Hi,
> > 
> > I've played lately a bit with Subversion and used it for managing
> > the kernel sources, using Larry McVoy's bk2cvs bridge and Ben Collins'
> > bkcvs2svn conversion script.
> > 
> > Since there is little information on the web on how to properly
> > set up a SVN repository and use it for tracking the latest kernel
> > tree, I wrote a small howto (modeled after the bk kernel howto)
> > in case it can be useful for other people too.
> > 
> > Feel free to comment on it (but let's not start a new BK flamewar
> > or SVN bashing session please). If there is enough interest I'll
> > submit a patch to include this in the kernel Documentation/ 
> > directory.
> > 
> > I've put it also on my web page along with the necessary scripts:
> > 	http://popies.net/svn-kernel/
> > 
> > And now a question to Larry and whoever else is involved in the
> > bkcvs mirror on kernel.org: what is the periodicity of the CVS
> > repository update ? 
> > 
> 
> Currently it's nightly.  Larry has offered to run it more often if
> someone can provide a dedicated fast machine to run it on.  (Larry: is
> it a matter of memory or of CPU or both?  If nothing else we should
> have the old kernel.org server, dual P3/1133 with 6 GB RAM, coming
> free soon.)
> 
> Please let me know if there is something that should be put on
> kernel.org; we can host repositories there of course.
> 
> 	-hpa

-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
