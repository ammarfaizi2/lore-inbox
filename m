Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVILTz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVILTz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVILTz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:55:28 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:50649 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932181AbVILTz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:55:26 -0400
Date: Mon, 12 Sep 2005 13:55:21 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
Message-ID: <20050912195521.GD32395@parisc-linux.org>
References: <1126308949.4799.54.camel@mulgrave> <20050910041218.29183.qmail@web51612.mail.yahoo.com> <20050911093847.GA5429@infradead.org> <20050912160805.GC32395@parisc-linux.org> <4325D1E8.9030302@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4325D1E8.9030302@adaptec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 03:07:20PM -0400, Luben Tuikov wrote:
> > A colleague asked me to summarise the current dispute.  I said that
> > Luben's point was that nobody else understood SCSI.  Everybody else's
> 
> No, my point is that SCSI Core "development" isn't following any
> spec or document or any formally accepted spec.

That's right.  And it's actually a good thing.  I'm sorry you find it so
hard to accept, but please stop telling us we're wrong and evil.

> And as more and more transports are coming aboard, you see more
> and more "kludge" from SPI making everything fit around the
> SCSI Core's legacy SPI as _opposed_ to _evolving_ SCSI Core.

Nobody wants to see that.  People do want the SCSI core to evolve.
It has evolved substantially in the last few years that I've been paying
attention.  Again, I'm sorry that it's not evolving in the direction that
you'd like it to, but you're not doing a very good job at persuading us
we're wrong.

> > Just discuss things on linux-scsi dispassionately.  There's no hidden
> 
> I have been, many times.
> 
> Absolutely no advice I've ever posted to linux-scsi has been accepted
> ever, unless someone else implemented it.
> 
> Any advice I've ever posted have been SAM/SPC related.

If the advice is couched in the same terms you've been using recently,
I'm not surprised.

> > agenda to get you or your company.  But you are pissing people off,
> > and very soon there *will* be because of your behaviour.
> 
> Personal threat on a public list?

Nope, just a prediction.  Perhaps I should have used 'shall' instead
of 'will'.  If you continue being abusive, you'll end up in peoples
killfiles, which would be a real shame.  If you think people are being
abusive towards you, please rise above it and don't attack them in
return.  We all want your cards supported by the SCSI layer in the best
possible way.  We just disagree about what that best possible way is.
I think we can all agree that the worst possible way is if somebody else
ends up writing a driver for your cards because your code isn't usable.
