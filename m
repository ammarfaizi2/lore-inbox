Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbTBEX1g>; Wed, 5 Feb 2003 18:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTBEX1g>; Wed, 5 Feb 2003 18:27:36 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:22788 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265134AbTBEX1g>; Wed, 5 Feb 2003 18:27:36 -0500
Date: Wed, 5 Feb 2003 23:37:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Larry McVoy <lm@work.bitmover.com>, Matt Reppert <arashi@yomerashi.yi.org>,
       Andrew Morton <akpm@digeo.com>, andrea@suse.de, lm@bitmover.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205233705.A31812@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Larry McVoy <lm@work.bitmover.com>,
	Matt Reppert <arashi@yomerashi.yi.org>,
	Andrew Morton <akpm@digeo.com>, andrea@suse.de, lm@bitmover.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205141104.6ae9e439.arashi@yomerashi.yi.org> <20030205233115.GB14131@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030205233115.GB14131@work.bitmover.com>; from lm@bitmover.com on Wed, Feb 05, 2003 at 03:31:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 03:31:15PM -0800, Larry McVoy wrote:
> We can go buy another machine for glibc2.3, I just need to know what redhat
> release uses that.  If there isn't one, what distro uses that?

redhat 8.0 uses a prerelease of glibc2.3, the current redhat beta uses
glibc 2.3.1+CVS, dito for debian unstable.

