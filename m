Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVDDRar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVDDRar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVDDRar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:30:47 -0400
Received: from [207.35.253.199] ([207.35.253.199]:23956 "EHLO
	smtp.discreet.com") by vger.kernel.org with ESMTP id S261300AbVDDRaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:30:39 -0400
Subject: Re: Assertion failure in journal_start_Rsmp_2519e07e()
From: Eric Desjardins <eric.desjardins@discreet.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1112634665.6270.66.camel@laptopd505.fenrus.org>
References: <1112633954.11836.2.camel@oshawa.rd.discreet.qc.ca>
	 <1112634665.6270.66.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112635820.11836.15.camel@oshawa.rd.discreet.qc.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 04 Apr 2005 13:30:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the answer.

I was just wandering if this was known.
... and yet getting in touch with my RH support person could
be a complex corporate problem involving several flavors of
action request...

Thanks again,
Eric

On Mon, 2005-04-04 at 13:11, Arjan van de Ven wrote:
> On Mon, 2005-04-04 at 12:59 -0400, Eric Desjardins wrote:
> > Hi,
> > 
> > I'm having problem with my x86_64 workstation. I'm having about
> > 5 kernels oops a day and usually I got that in the syslog:
> > 
> > Apr  4 12:45:07 oshawa kernel: Assertion failure in
> > journal_start_Rsmp_2519e07e() at transaction.c:249:
> > "handle->h_transaction->t_journal == journal"
> > 
> > I'm using:
> > Linux oshawa 2.4.21-20.ELsmp #2 SMP Wed Mar 23 18:32:06 EST 2005 x86_64
> > x86_64 x86_64 GNU/Linux.
> > 
> > Any idea where I should start to look at.
> 
> your RH support person?
> Or at least an updated kernel...
