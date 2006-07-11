Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWGKQI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWGKQI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWGKQI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:08:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61379 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751081AbWGKQI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:08:56 -0400
Subject: Re: [patch] let CONFIG_SECCOMP default to n
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andrea@cpushare.com
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060711153117.GJ7192@opteron.random>
References: <20060629192121.GC19712@stusta.de>
	 <1151628246.22380.58.camel@mindpipe>
	 <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de>
	 <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu>
	 <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu>
	 <20060711141709.GE7192@opteron.random>
	 <1152628374.3128.66.camel@laptopd505.fenrus.org>
	 <20060711153117.GJ7192@opteron.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 17:24:15 +0100
Message-Id: <1152635055.18028.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 17:31 +0200, ysgrifennodd andrea@cpushare.com:
> If they don't reconsider I'll be forced to recommend the Fedora CPUShare
> users to switch distro if they don't want having to recompile the kernel
> by themself.

I'm sure they'll both be deeply upset.

I really don't care about cpushare and patents for some users of the
code in question. On the other hand turning on performance harming code
for a tiny number of users is dumb. If it were a loadable module it
would be different.


Alan

