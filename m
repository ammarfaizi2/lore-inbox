Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262563AbSI0U7D>; Fri, 27 Sep 2002 16:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbSI0U7D>; Fri, 27 Sep 2002 16:59:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13758 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262563AbSI0U7C>;
	Fri, 27 Sep 2002 16:59:02 -0400
Date: Fri, 27 Sep 2002 23:13:32 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.3.96.1020927164720.4440A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0209272312020.21134-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Call Trace:
> >   [<c0112a40>] do_page_fault+0x0/0x4a2
> >   [<c0107973>] syscall_call+0x7/0xb

> I think that's a great idea.

it's already in the kksymoops patch that Linus applied two days ago.

	Ingo

