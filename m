Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262593AbSI0U4f>; Fri, 27 Sep 2002 16:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbSI0U4f>; Fri, 27 Sep 2002 16:56:35 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32779 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262593AbSI0U4e>; Fri, 27 Sep 2002 16:56:34 -0400
Date: Fri, 27 Sep 2002 16:48:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <20020925220447.GA1573@werewolf.able.es>
Message-ID: <Pine.LNX.3.96.1020927164720.4440A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, J.A. Magallon wrote:

> Sorry to be picky, but...

> ...wouldn't this look much nicer with some '\n' and a couple space for indent ?
> 
> Stack:
>   4001695c bffff414 40156154 00000004 c0112a40 cef9e000 400168e4 bffffb44
>   c0107973 00000000 00000000 40156154 400168e4 bffffb44 bffffad8 0000004e
>   0000002b 0000002b 0000004e 400cecc1 00000023 00000246 bffffacc 0000002b
> Call Trace:
>   [<c0112a40>] do_page_fault+0x0/0x4a2
>   [<c0107973>] syscall_call+0x7/0xb

You mean like making it human readable? ;-)

I think that's a great idea.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

