Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130699AbRBPRbe>; Fri, 16 Feb 2001 12:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130706AbRBPRbY>; Fri, 16 Feb 2001 12:31:24 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:30123 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130699AbRBPRbO>; Fri, 16 Feb 2001 12:31:14 -0500
Date: Fri, 16 Feb 2001 12:29:41 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <20010216174316.A4500@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.30.0102161229090.17251-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001, Jamie Lokier wrote:

> It should be fast on known CPUs, correct on unknown ones, and much
> simpler than "gather" code which may be completely unnecessary and
> rather difficult to test.
>
> If anyone reports the message, _then_ we think about the problem some more.
>
> Ben, fancy writing a boot-time test?

Sure, I'll whip one up this afternoon.

		-ben

