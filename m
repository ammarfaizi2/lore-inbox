Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290387AbSAPJUU>; Wed, 16 Jan 2002 04:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290400AbSAPJUB>; Wed, 16 Jan 2002 04:20:01 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:55721 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290389AbSAPJRd>; Wed, 16 Jan 2002 04:17:33 -0500
Date: Wed, 16 Jan 2002 04:17:21 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: <mingo@devserv.devel.redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] I3 sched tweaks...
In-Reply-To: <Pine.LNX.4.33.0201160412180.24929-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0201160416570.27896-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 3) lock_task_rq returns the rq, rather than assigning it, for clarity.

i've made it an inline function instead of a macro.

	Ingo

