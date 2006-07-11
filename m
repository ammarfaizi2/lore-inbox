Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWGKQJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWGKQJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGKQJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:09:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62147 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751107AbWGKQJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:09:54 -0400
Subject: Re: [patch] let CONFIG_SECCOMP default to n
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: andrea@cpushare.com, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1152633242.3128.81.camel@laptopd505.fenrus.org>
References: <20060629192121.GC19712@stusta.de>
	 <1151628246.22380.58.camel@mindpipe>
	 <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de>
	 <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu>
	 <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu>
	 <20060711141709.GE7192@opteron.random>
	 <1152628374.3128.66.camel@laptopd505.fenrus.org>
	 <20060711153117.GJ7192@opteron.random>
	 <1152633242.3128.81.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 17:25:32 +0100
Message-Id: <1152635132.18028.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 17:54 +0200, ysgrifennodd Arjan van de Ven:
> On Tue, 2006-07-11 at 17:31 +0200, andrea@cpushare.com wrote:
> Fedora is done by the Fedora project, not by Red Hat the company. If you
> want to ask them to enable it, you should do so on the fedora-devel
> mailing list

Or roll your own alternative kernel package and set up a mini yum
repository for it and updates you make. The GPL is a wonderful thing 8)

