Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbRESGlE>; Sat, 19 May 2001 02:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbRESGky>; Sat, 19 May 2001 02:40:54 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:19136 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261664AbRESGkl>; Sat, 19 May 2001 02:40:41 -0400
Date: Sat, 19 May 2001 02:40:41 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200105190640.f4J6efG11140@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <mailman.990252541.15890.linux-kernel2news@redhat.com>
In-Reply-To: <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518093414.A21164@qcc.sk.ca> <mailman.990252541.15890.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[about Aunt Tullie]
> Because, for example, a kernel compile can be a part of the standard 
> install now, and you will end up with a kernel built specifically for 
> your machine that doesn't print 50 initialization failed messages on boot.
>[...]
> And you can also now run a kernel built for your shiny new Athlon, not 
> the old piece of shit that was hot stuff in '92.

It is way too easy to crush your example, by pointing out that
Red Hat ships and automatically installs an Athlon-optimized kernel.

However, the argument above is wrong even if Red Hat did not.
We are talking about CML2 and interaction with Aunt Tullie.
This has nothing to do with automated rebuild at install time.

-- Pete
