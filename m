Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264535AbUEYDtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUEYDtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 23:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264541AbUEYDtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 23:49:51 -0400
Received: from waste.org ([209.173.204.2]:18320 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264535AbUEYDtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 23:49:49 -0400
Date: Mon, 24 May 2004 22:49:20 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040525034920.GY5414@waste.org>
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org> <200405242250.38442.tglx@linutronix.de> <Pine.LNX.4.58.0405241400280.32189@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405241400280.32189@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 02:05:40PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 24 May 2004, Thomas Gleixner wrote:
> > 
> > What I'm missing in this discussion is a clear distinction between patches and 
> > contributions.
> 
> Well, I'm not sure such a clear distinction exists.

Actually, there is a question as to how to sign off on something that
eventually gets rolled into something larger? Simply collect all the
signatories? Andrew aggregates patches on a fairly regular basis. How
about stuff that gets merged from the CVS trees of public projects? I
think we need a way to say "this came from an aggregate external
source" for patches that aren't simply passed along one by one.
Perhaps something like:

Signed-off-by: J Random hacker <foo@bar.com> from http://baz.sourceforge.net

> Any process that doesn't allow for common sense is just broken, and
> clearly from a _legal_ standpoint it doesn't matter if we track who fixed
> out (atrocious) spelling errors.

"our"

-- 
Mathematics is the supreme nostalgia of our time.
