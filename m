Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268589AbUI2Pky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbUI2Pky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268580AbUI2Pky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:40:54 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:37587 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268589AbUI2Pkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:40:33 -0400
Date: Wed, 29 Sep 2004 17:40:25 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040929154025.GC22008@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random> <1096272553.6572.3.camel@laptop.fenrus.com> <20040927130919.GE28865@dualathlon.random> <20040928194351.GC5037@devserv.devel.redhat.com> <20040928221933.GG4084@dualathlon.random> <20040929060521.GA6975@devserv.devel.redhat.com> <20040929141151.GJ4084@dualathlon.random> <20040929142521.GB22928@devserv.devel.redhat.com> <20040929145344.GA22008@dualathlon.random> <20040929150148.GA14722@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929150148.GA14722@devserv.devel.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 05:01:48PM +0200, Arjan van de Ven wrote:
> and you would have known it too if you had looked up the changeset that
> implemented flex mmap since it was documented there.

I did read the source from kernel CVS and I don't see any mention of
that in the sourcecode, I value source more than metadata in CVS logs.
