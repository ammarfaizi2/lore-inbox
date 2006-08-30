Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWH3NQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWH3NQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 09:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWH3NQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 09:16:22 -0400
Received: from 1wt.eu ([62.212.114.60]:41489 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751004AbWH3NQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 09:16:22 -0400
Date: Wed, 30 Aug 2006 15:16:12 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: davej@redhat.com, pageexec@freemail.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] exception processing in early boot
Message-ID: <20060830131612.GB351@1wt.eu>
References: <20060830063932.GB289@1wt.eu> <p73y7t65z6c.fsf@verdi.suse.de> <20060830121845.GA351@1wt.eu> <200608301459.15008.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608301459.15008.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 02:59:14PM +0200, Andi Kleen wrote:
> 
> > Unfortunately, this situation is even more difficult for me, because it's
> > getting very hard to track patches that get applied, rejected, modified or
> > obsoleted, which is even more true when people don't always think about
> > sending an ACK after the patch finally gets in. I already have a few pending
> > patches in my queue waiting for an ACK that will have to be tracked if the
> > persons do not respond, say, within one week. Otherwise I might simply lose
> > them.
> 
> It shouldn't be that hard to check gitweb or git output occasionally
> for the patches. You can probably even automate that.

That's already what I'm doing, and yes, it is *that* hard. We're literally
speaking about *thousands* of patches. It's as difficult to find one patch
within 2.6 git changes as it is to find a useful mail in the middle of 99%
spam. This is not because of GIT but because of the number of changes.

> > I think that the good method would be to :
> >   - announce the patch
> >   - find a volunteer to port it
> >   - apply it once the volunteer agrees to handle it
> > This way, no code gets lost because there's always someone to track it.
> 
> I can put that one into my tree for .19

Thanks for this andi,
Willy

