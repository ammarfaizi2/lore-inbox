Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbTENQJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTENQJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:09:13 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:51590 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S261839AbTENQJK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:09:10 -0400
Date: Wed, 14 May 2003 09:21:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Christoph Hellwig <hch@infradead.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030514162148.GB830@ip68-0-152-218.tc.ph.cox.net>
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk> <20030513163854.A27407@infradead.org> <20030513131754.7f96d4d0.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513131754.7f96d4d0.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 01:17:54PM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > That brings up another issue:  what ports do regularly work with 2.5
> >  mainline?
> 
> I test ppc64 regularly.  In fact -mm is probably the best place to go to
> get a working ppc64 tree at present.
> 
> But I do not view non-ia32 support as being a 2.6.0 requirement.  I'd be OK
> with 2.6.0 working _only_ on ia32.  Other architectures will catch up when
> they can.  The only core requirement is that 2.6.0 not contain gross
> x86isms which make other ports impossible.

How about some holding point shortly before to ping arch maintainers?
I'm sure a number of arches will be at 'current bk works, but Linus
keeps dropping my emails' stage.

-- 
Tom Rini
http://gate.crashing.org/~trini/
