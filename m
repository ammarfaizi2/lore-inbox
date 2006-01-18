Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWARUw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWARUw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWARUw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:52:26 -0500
Received: from havoc.gtf.org ([69.61.125.42]:13699 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030447AbWARUwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:52:25 -0500
Date: Wed, 18 Jan 2006 15:52:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@suse.cz,
       softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
Subject: Re: wireless: the contenders
Message-ID: <20060118205221.GA11270@havoc.gtf.org>
References: <20060118200616.GC6583@tuxdriver.com> <43CEA6EB.6080209@pobox.com> <20060118204844.GE6583@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118204844.GE6583@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 03:48:49PM -0500, John W. Linville wrote:
> On Wed, Jan 18, 2006 at 03:36:59PM -0500, Jeff Garzik wrote:
> > John W. Linville wrote:
> 
> > >The "master" branch of that tree is (mostly) up-to-date w/ Linus, plus
> > >changes I recently sent to Jeff.  Those changes are also available on
> > >the "upstream-jgarzik" branch, but it is frozen to when I requested
> > >Jeff's pull.
> 
> > Typically I do not update 'master' unless I am also updating 'upstream' 
> > with vanilla Linus changes, in order to avoid screwing up the tree heads 
> > and the diff.  When I do update 'master' from 'upstream', it is a 
> > trivial matter to then pull those changes into 'upstream':
> 
> Good info...thanks!
> 
> FWIW, I have an "origin" branch that corresponds to Linus' tree.
> I think that probably enables the same kind of usage as you noted...?

Yep, it doesn't matter what you call it.

I avoid 'origin' since a 'git pull' without arguments will automatically
update that (and possibly master too).

But it's just a name.  Any branch with vanilla Linus tree in it will
achieve the behavior I described.

	Jeff



