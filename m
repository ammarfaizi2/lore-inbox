Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbTBEXre>; Wed, 5 Feb 2003 18:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTBEXre>; Wed, 5 Feb 2003 18:47:34 -0500
Received: from bitmover.com ([192.132.92.2]:11706 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265177AbTBEXrd>;
	Wed, 5 Feb 2003 18:47:33 -0500
Date: Wed, 5 Feb 2003 15:57:06 -0800
From: Larry McVoy <lm@bitmover.com>
To: Christoph Hellwig <hch@infradead.org>,
       Matt Reppert <arashi@yomerashi.yi.org>, Andrew Morton <akpm@digeo.com>,
       andrea@suse.de, lm@bitmover.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205235706.GB21064@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matt Reppert <arashi@yomerashi.yi.org>,
	Andrew Morton <akpm@digeo.com>, andrea@suse.de, lm@bitmover.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205141104.6ae9e439.arashi@yomerashi.yi.org> <20030205233115.GB14131@work.bitmover.com> <20030205233705.A31812@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205233705.A31812@infradead.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 11:37:05PM +0000, Christoph Hellwig wrote:
> On Wed, Feb 05, 2003 at 03:31:15PM -0800, Larry McVoy wrote:
> > We can go buy another machine for glibc2.3, I just need to know what redhat
> > release uses that.  If there isn't one, what distro uses that?
> 
> redhat 8.0 uses a prerelease of glibc2.3, the current redhat beta uses
> glibc 2.3.1+CVS, dito for debian unstable.

And is everyone happy with 8.0's glibc, if we offer that up until 8.1 comes
out?  If so, we'll buy a machine and add it to the build cluster this week.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
