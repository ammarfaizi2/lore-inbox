Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbUKLQvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbUKLQvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUKLQtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:49:05 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:28685 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262581AbUKLQrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:47:55 -0500
Date: Fri, 12 Nov 2004 16:47:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Reiser{3,4}: problem with the copyright statement
Message-ID: <20041112164745.GB7308@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <20041111012333.1b529478.akpm@osdl.org> <20041111214554.GB2310@stusta.de> <Pine.LNX.4.58.0411111355020.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411111355020.2301@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 01:59:37PM -0800, Linus Torvalds wrote:
> > I have no problem with dual-licensed code, but I do strongly dislike 
> > having this "unlike you explicitley state otherwise, you transfer all 
> > rights to Hans Reiser" in the kernel.
> 
> I don't see any reasonable alternatives. The alternative is for Hans 
> Reiser to not be able to merge with the kernel, which is kind of against 
> the _point_ of having a dual license.

If you touch e.g. XFS for a non-trivial change you'll also get a mail from
SGI politely asking to assign your copyright.  Doing this implicit is IMHO
a reall bad thing.

IF you really think it's something we should do the least thing to do is
to put a BIG WAIVER into every file for which this is in effect.

