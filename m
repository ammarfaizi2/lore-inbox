Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268035AbTAKT1P>; Sat, 11 Jan 2003 14:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268007AbTAKT1P>; Sat, 11 Jan 2003 14:27:15 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:25861 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268035AbTAKT1O>; Sat, 11 Jan 2003 14:27:14 -0500
Date: Sat, 11 Jan 2003 19:36:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: make AT_SYSINFO platform-independent
Message-ID: <20030111193600.A6382@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ulrich Drepper <drepper@redhat.com>, davidm@hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <20030111185744.A5009@infradead.org> <Pine.LNX.4.44.0301111128150.25432-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0301111128150.25432-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Jan 11, 2003 at 11:29:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:29:14AM -0800, Linus Torvalds wrote:
> 
> On Sat, 11 Jan 2003, Christoph Hellwig wrote:
> > 
> > -EWHATSUP
> 
> Ehh, Uli is a bit sensitive, and thinks everybody blames him for 
> everything. I told him the AT_SYSINFO interface is stable, so he wants to 
> make it clear that _I_ am the one to blame, not him.

Oh, I have absolutely no problem to blame you 8)

> Anyway, as I said in another mail, I think 18 is a bad choice, and I'll 
> leave it at 32.

But please at least fixup the comment that talks about x86-specific entries
starting at 32 then.

