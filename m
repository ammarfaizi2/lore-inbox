Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWIYMCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWIYMCK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWIYMCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:02:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39652 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932080AbWIYMCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:02:07 -0400
Date: Mon, 25 Sep 2006 13:53:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060925115352.GA15705@elte.hu>
References: <20060920135438.d7dd362b.akpm@osdl.org> <45121382.1090403@garzik.org> <20060920220744.0427539d.akpm@osdl.org> <1158830206.11109.84.camel@localhost.localdomain> <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org> <20060921105959.a55efb5f.akpm@osdl.org> <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <20060924185100.GA20524@elte.hu> <451747EE.50900@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451747EE.50900@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> OTOH, if we were worried about confusing people, we wouldn't be using 
> the acronym 'rc' for our 'Ridiculous Count', and have our rc1 denote 
> the result of 2 weeks of stuffing the tree with new features and 
> intrusive changes, where people might mistake that for the much more 
> common RC-as-in-'Release Candidate'. :)

oh, we could call the first one -rc0 then :-)

	Ingo
