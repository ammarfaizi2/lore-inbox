Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSFTQmz>; Thu, 20 Jun 2002 12:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSFTQmU>; Thu, 20 Jun 2002 12:42:20 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:5131 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S315279AbSFTQlz>;
	Thu, 20 Jun 2002 12:41:55 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 20 Jun 2002 10:30:03 -0600
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020620103003.C6243@host110.fsmlabs.com>
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com> <m1d6umtxe8.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1d6umtxe8.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Wed, Jun 19, 2002 at 09:57:35PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Beating the SMP horse to death" does make sense for 2 processor SMP
machines.  When 64 processor machines become commodity (Linux is a
commodity hardware OS) something will have to be done.  When research
groups put Linux on 1k processors - it's an experiment.  I don't think they
have much right to complain that Linux doesn't scale up to that level -
it's not designed to.

That being said, large clusters are an interesting research area but it is
_not_ a failing of Linux that it doesn't scale to them.
