Return-Path: <linux-kernel-owner+w=401wt.eu-S1754739AbWL0U41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbWL0U41 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 15:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbWL0U41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 15:56:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:52225 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774AbWL0U40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 15:56:26 -0500
Date: Wed, 27 Dec 2006 21:54:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] update kmap_atomic on !HIGHMEM
Message-ID: <20061227205403.GA8464@elte.hu>
References: <20061227193550.324850000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227193550.324850000@mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=BAYES_40 autolearn=no SpamAssassin version=3.0.3
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.2469]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> I got some scheduling while atomic on x86-64 , [...]

please post those messages too.

	Ingo
