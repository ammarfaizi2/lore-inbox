Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317869AbSFSMkL>; Wed, 19 Jun 2002 08:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317870AbSFSMkK>; Wed, 19 Jun 2002 08:40:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21099 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317869AbSFSMkJ>; Wed, 19 Jun 2002 08:40:09 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.33.0206181442050.2562-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Jun 2002 06:29:59 -0600
In-Reply-To: <Pine.LNX.4.33.0206181442050.2562-100000@penguin.transmeta.com>
Message-ID: <m1hejztprs.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> If we end up using a default of 1024, maybe you'll have to recompile that
> part of the system that has anything to do with CPU affinity in about
> 10-20 years by just upping the number a bit. Quite frankly, that's going
> to be the _least_ of the issues.

:)

10-20 years or someone finds a good way to implement a single system
image on linux clusters.  They are already into the 1000s of nodes,
and dual processors per node category.  And as things continue they
might even grow bigger.

Eric
