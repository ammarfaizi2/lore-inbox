Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWHVVYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWHVVYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWHVVYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:24:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49380
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751300AbWHVVYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:24:44 -0400
Date: Tue, 22 Aug 2006 14:25:00 -0700 (PDT)
Message-Id: <20060822.142500.11271092.davem@davemloft.net>
To: nmiell@comcast.net
Cc: jmorris@namei.org, johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org,
       drepper@redhat.com, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com, hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1156281220.2476.65.camel@entropy>
References: <1156276823.2476.22.camel@entropy>
	<20060822.133606.48392664.davem@davemloft.net>
	<1156281220.2476.65.camel@entropy>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Miell <nmiell@comcast.net>
Date: Tue, 22 Aug 2006 14:13:40 -0700

> And how is the quality of the work to be judged if the work isn't
> commented, documented and explained, especially the userland-visible
> parts that *cannot* *ever* *be* *changed* *or* *removed* once they're in
> a stable kernel release?

Are you even willing to look at the collection of example applications
Evgeniy wrote against this API?

That is the true test of a set of interfaces, what happens when you
try to actually use them in real programs.

Everything else is fluff, including standards and "documentation".

He even bothered to benchmark things, and post assosciated graphs and
performance analysis during the course of development.
