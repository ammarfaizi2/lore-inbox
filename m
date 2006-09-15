Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWIONTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWIONTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWIONTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:19:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49297 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751404AbWIONS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:18:59 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <Pine.LNX.4.64.0609151425180.6761@scrub.home>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>
	 <20060914135548.GA24393@elte.hu>
	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>
	 <20060914171320.GB1105@elte.hu>
	 <Pine.LNX.4.64.0609141935080.6761@scrub.home>
	 <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com>
	 <1158320406.29932.16.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609151339190.6761@scrub.home>
	 <1158323938.29932.23.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609151425180.6761@scrub.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 14:41:36 +0100
Message-Id: <1158327696.29932.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 14:39 +0200, ysgrifennodd Roman Zippel:
> Both points have very strong consequences regarding complexity. Why do you 
> want to deny me the choice to use something simple, especially since both 
> solutions are not mutually exclusive and can even complement each other? 

I don't want to deny you the choice, I just don't want to see
unneccessary garbage in the base kernel. What you put in your own toilet
is a private matter. What you leave out in a public place is different.

> What's the point in forcing everyone to use a single solution?

Maintainability ? common good over individual weirdnesses ? Ability for
people to concentrate on getting one good set of interfaces not twelve
bad ones ? Consistency for user space ?

Alan

