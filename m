Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbTGZUhh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbTGZUhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:37:37 -0400
Received: from dsl093-172-075.pit1.dsl.speakeasy.net ([66.93.172.75]:31374
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S269623AbTGZUhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:37:35 -0400
Date: Sat, 26 Jul 2003 16:52:27 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] use ext2/ext3 consistently in Kconfig
Message-ID: <20030726205227.GL28205@kurtwerks.com>
References: <20030726195722.GB16160@louise.pinerecords.com> <200307261621.55553.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307261621.55553.jeffpc@optonline.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Jeff Sipek:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Saturday 26 July 2003 15:57, Tomas Szepe wrote:
> <snip>
> > @@ -89,7 +89,7 @@
> >         tristate "Ext3 journalling file system support"
> >         help
> >           This is the journaling version of the Second extended file system
> > -         (often called ext3), the de facto standard Linux file system
> > +         (often called ext2), the de facto standard Linux file system
> 
> The journaling version is ext3, not ext2...

But the confusion really just points out that this help text is
grammatically challenged.

Kurt
-- 
After living in New York, you trust nobody, but you believe
everything.  Just in case.
