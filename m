Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVBJPWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVBJPWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 10:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVBJPWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 10:22:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:46307 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262138AbVBJPV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 10:21:59 -0500
Date: Thu, 10 Feb 2005 16:21:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jakob Oestergaard <jakob@unthought.net>, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: the "Turing Attack" (was: Sabotaged PaXtest)
Message-ID: <20050210152149.GA6697@elte.hu>
References: <42080689.15768.1B0C5E5F@localhost> <42093CC7.5086.1FC83D3E@localhost> <20050208164815.GA9903@elte.hu> <20050208220851.GA23687@elte.hu> <20050210134314.GA4146@elte.hu> <20050210135845.GT347@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210135845.GT347@unthought.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jakob Oestergaard <jakob@unthought.net> wrote:

> On Thu, Feb 10, 2005 at 02:43:14PM +0100, Ingo Molnar wrote:
> > 
> > * pageexec@freemail.hu <pageexec@freemail.hu> wrote:
> > 
> > > the bigger problem is however that you're once again fixing the
> > > symptoms, instead of the underlying problem - not the correct
> > > approach/mindset.
> > 
> > i'll change my approach/mindset when it is proven that "the underlying
> > problem" can be solved. (in a deterministic fashion)
> 
> I know neither exec-shield nor PaX and therefore have no bias or
> preference - I thought I should chirp in on your comment here Ingo...
> 
> ...
> > PaX cannot be a 'little bit pregnant'. (you might argue that exec-shield
> > is in the 6th month, but that does not change the fundamental
> > end-result: a child will be born ;-)
> 
> Yes and no.  I would think that the chances of a child being born are
> greater if the pregnancy has lasted successfully up until the 6th month,
> compared to a first week pregnancy.
> 
> I assume you get my point  :)

the important point is: neither PaX nor exec-shield can claim _for sure_
that no child will be born, and neither can claim virginity ;-)

[ but i guess there's a point where a bad analogy must stop ;) ]

	Ingo
