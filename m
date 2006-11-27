Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935674AbWK1ImO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935674AbWK1ImO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935689AbWK1ImN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:42:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:19899 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935674AbWK1ImM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:42:12 -0500
Date: Mon, 27 Nov 2006 08:48:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt5
Message-ID: <20061127074822.GA1606@elte.hu>
References: <20061120220230.GA30835@elte.hu> <200611261539.48105.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611261539.48105.fzu@wemgehoertderstaat.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00,DATE_IN_PAST_24_48 autolearn=no SpamAssassin version=3.0.3
	0.1 DATE_IN_PAST_24_48     Date: is 24 to 48 hours before Received: date
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0022]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

> this fixes issues like rmmod hanging and inodes leaking.

thanks ... i have reverted the other dcache.c changes as well.

	Ingo
