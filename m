Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318690AbSHNOFB>; Wed, 14 Aug 2002 10:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSHNOFB>; Wed, 14 Aug 2002 10:05:01 -0400
Received: from dp.samba.org ([66.70.73.150]:8583 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318690AbSHNOFB>;
	Wed, 14 Aug 2002 10:05:01 -0400
Date: Wed, 14 Aug 2002 23:48:24 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] clone_startup(), 2.5.31-A0
Message-Id: <20020814234824.08faf190.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0208131921020.4369-100000@localhost.localdomain>
References: <20020813164415.A11554@infradead.org>
	<Pine.LNX.4.44.0208131921020.4369-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002 19:27:35 +0200 (CEST)
Ingo Molnar <mingo@elte.hu> wrote:

> btw., with the help of these syscalls and futexes, the layer between Linux
> and pthreads became very thin - almost nonexistant in the majority of
> cases.

Woohoo!

Please send futex patch BTW, I wanna see 8)

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
