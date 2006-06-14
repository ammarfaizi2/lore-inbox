Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWFNSSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWFNSSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 14:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWFNSSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 14:18:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:30174 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932363AbWFNSSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 14:18:40 -0400
Date: Wed, 14 Jun 2006 20:17:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 0/8] lock validator: s390 support
Message-ID: <20060614181736.GA31243@elte.hu>
References: <20060614141537.GA1241@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614141537.GA1241@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> Hi,
> 
> following is a series of patches needed to get the lock validator 
> running on s390. Patches are against linux-2.6.17-rc6-mm2 + 
> lockdep-combo-2.6.17-rc6-mm2.patch (from 13th of june). Seems to work 
> so far.

great work! Looks really clean and complete.

	Ingo
