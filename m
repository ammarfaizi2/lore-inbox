Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbUKLROH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUKLROH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 12:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUKLRMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 12:12:31 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:30989 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262588AbUKLRGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 12:06:39 -0500
Date: Fri, 12 Nov 2004 17:06:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiser{3,4}: problem with the copyright statement
Message-ID: <20041112170636.GA7689@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <20041111012333.1b529478.akpm@osdl.org> <20041111214554.GB2310@stusta.de> <Pine.LNX.4.58.0411111355020.2301@ppc970.osdl.org> <20041112164745.GB7308@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112164745.GB7308@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 04:47:45PM +0000, Christoph Hellwig wrote:
> On Thu, Nov 11, 2004 at 01:59:37PM -0800, Linus Torvalds wrote:
> > > I have no problem with dual-licensed code, but I do strongly dislike 
> > > having this "unlike you explicitley state otherwise, you transfer all 
> > > rights to Hans Reiser" in the kernel.
> > 
> > I don't see any reasonable alternatives. The alternative is for Hans 
> > Reiser to not be able to merge with the kernel, which is kind of against 
> > the _point_ of having a dual license.
> 
> If you touch e.g. XFS for a non-trivial change you'll also get a mail from
> SGI politely asking to assign your copyright.  Doing this implicit is IMHO
> a really bad thing.

Btw, reiser3 handling was similar.  At least Hans wanted an assigment from
me for even really trivial changes (which I still insist aren't copyrightable)

