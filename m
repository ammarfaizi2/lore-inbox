Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbUJ1G3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbUJ1G3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbUJ1G10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:27:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15270 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262799AbUJ1GZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:25:42 -0400
Date: Thu, 28 Oct 2004 08:26:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <darren@dvhart.com>
Cc: Matt Dobson <colpatch@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] active_load_balance() fixlet
Message-ID: <20041028062656.GA9781@elte.hu>
References: <1098921429.20183.27.camel@arrakis> <1098921793.17741.8.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098921793.17741.8.camel@farah.beaverton.ibm.com>
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


* Darren Hart <darren@dvhart.com> wrote:

> On Wed, 2004-10-27 at 16:57 -0700, Matthew Dobson wrote:
> > Darren, Andrew, and scheduler folks,
> > 
> > There is a small problem with the active_load_balance() patch that
> > Darren sent out last week.
> 
> This cleans up some awkward tests in my patch as well.  Looks good to
> me.

could you send a combined patch for review?

	Ingo
