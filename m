Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSJAFKC>; Tue, 1 Oct 2002 01:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261488AbSJAFKC>; Tue, 1 Oct 2002 01:10:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61316 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261486AbSJAFKB>;
	Tue, 1 Oct 2002 01:10:01 -0400
Date: Tue, 1 Oct 2002 07:24:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: george@mvista.com, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <wli@holomorphy.com>,
       <dipankar@in.ibm.com>, <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
In-Reply-To: <20020930.211848.131274580.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210010723460.5969-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Sep 2002, David S. Miller wrote:

> I did some thinking, and I don't understand how this old code can be
> legal.  Doesn't this make do_gettimeofday() inaccurate?

it's a mostly bogus comment, dont think about it too much.

	Ingo

