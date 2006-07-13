Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWGMNqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWGMNqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWGMNqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:46:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:2767 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751312AbWGMNqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:46:46 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: utrace vs. ptrace
Date: Thu, 13 Jul 2006 15:46:39 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>, Albert Cahalan <acahalan@gmail.com>,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com> <200607131534.16819.ak@suse.de> <1152797870.3024.54.camel@laptopd505.fenrus.org>
In-Reply-To: <1152797870.3024.54.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607131546.39718.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> are you sure? I had this working in the 2.6.9 timeframe, I could set
> core pattern to /tmp/corefiles/core and such just fine..
> (and the core files ended up in the /tmp/corefiles/ directory as well)

Hmm, yes maybe it has changed. When I tried it originally (which was before 2.6.9)
it didn't work

-Andi

