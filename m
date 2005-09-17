Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVIQJWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVIQJWx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 05:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVIQJWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 05:22:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43987 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750989AbVIQJWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 05:22:52 -0400
Date: Sat, 17 Sep 2005 10:22:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050917092247.GA13992@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com> <20050916174028.GA32745@infradead.org> <432B1F84.3000902@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432B1F84.3000902@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 12:39:48PM -0700, Hans Reiser wrote:
> Christoph Hellwig wrote:
> 
> >additinoal comment is that the code is very messy, very different
> >from normal kernel style, full of indirections and thus hard to read.
> >
> 
> Most of my customers remark that Namesys code is head and shoulders
> above the rest of the kernel code.  So yes, it is different.  In
> particular, they cite the XFS code as being so incredibly hard to read
> that its unreadability is worth hundreds of thousands of dollars in
> license fees for me.  That's cash received, from persons who read it
> all, not commentary made idly.

It's very different from kernel style, and it's hard to read for us kernel
developers.  And yes, I don't think XFS is the most easy to read code either,
quite contrary.  But it's at least half a magnitude less bad than reiser4
code..

