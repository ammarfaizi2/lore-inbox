Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVEYIRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVEYIRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 04:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVEYIRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 04:17:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34502 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261154AbVEYIRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 04:17:04 -0400
Date: Wed, 25 May 2005 10:16:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Daniel Walker <dwalker@mvista.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050525081644.GA23336@elte.hu>
References: <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu> <4292F074.7010104@yahoo.com.au> <1116957953.31174.37.camel@dhcp153.mvista.com> <20050524224157.GA17781@nietzsche.lynx.com> <4293E4ED.7030804@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4293E4ED.7030804@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> Bill Huey (hui) wrote:
> > I think there's a lot of general ignorance regarding this patch, the
> > usefulness of it and this thread is partially addressing them.
> 
> Forgive the dumb question:
> Why isn't anyone doing a presentation about Ingo's patch at the OLS
> this year?

(i guess mostly because i'm pretty presentation-shy. It's probably too 
late for OLS, but if someone else feels a desire to do more in this 
area, i certainly wont complain.)

> Currently, looking at the listed presentations, apart from finding 
> myself thinking "hm..., I swear that guy did the same presentation 
> last year ... and maybe the year before", I can't see any entry 
> alluding to rt-preempt ... maybe I missed it?

you could not have seen it a year ago because it simple didnt exist back 
then :) I started implementing the PREEMPT_RT model roughly half a year 
ago.

	Ingo
