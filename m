Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbSI0X4p>; Fri, 27 Sep 2002 19:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262651AbSI0X4p>; Fri, 27 Sep 2002 19:56:45 -0400
Received: from jalon.able.es ([212.97.163.2]:12681 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262649AbSI0X4o>;
	Fri, 27 Sep 2002 19:56:44 -0400
Date: Sat, 28 Sep 2002 01:58:41 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Davidsen <davidsen@tmr.com>, "J.A. Magallon" <jamagallon@able.es>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
Message-ID: <20020927235841.GA1558@werewolf.able.es>
References: <Pine.LNX.4.44.0209272312020.21134-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0209272312020.21134-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Sep 27, 2002 at 23:13:32 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.27 Ingo Molnar wrote:
>
>> > Call Trace:
>> >   [<c0112a40>] do_page_fault+0x0/0x4a2
>> >   [<c0107973>] syscall_call+0x7/0xb
>
>> I think that's a great idea.
>
>it's already in the kksymoops patch that Linus applied two days ago.
>

Any version of this for 2.4 ? I think this is going to be very, very usefull,
so it is interesting to have it on 2.4...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre8-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
