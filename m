Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVHYX7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVHYX7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 19:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVHYX7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 19:59:13 -0400
Received: from gemini.smart.net ([66.225.112.69]:8972 "EHLO gemini.smart.net")
	by vger.kernel.org with ESMTP id S965028AbVHYX7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 19:59:13 -0400
Message-ID: <430E5B8E.5C89A06B@smart.net>
Date: Thu, 25 Aug 2005 20:00:14 -0400
From: "Daniel B." <dsb@smart.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18+dsb+smp+ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>
		 <f192987705061310202e2d9309@mail.gmail.com>
		 <1118690448.13770.12.camel@localhost.localdomain>
		 <200506152149.06367.pmcfarland@downeast.net>
		 <20050616023630.GC9773@thunk.org> <87y89a7wfn.fsf@jbms.ath.cx>
		 <20050616143727.GC10969@thunk.org>  <20050619175503.GA3193@elf.ucw.cz> <1119292723.3279.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Sul, 2005-06-19 at 18:55, Pavel Machek wrote:
> ...
> >
> > If we are serious about utf-8 support in ext3, we should return
> > -EINVAL if someone passes non-canonical utf-8 string.
> 
> That would ironically not be standards compliant

Which standards?

The standards I've read (mostly XML- and web-related specs)
do say that non-standard UTF-8 octet sequences should be rejected.


Daniel
-- 
Daniel Barclay
dsb@smart.net
