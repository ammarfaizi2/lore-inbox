Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317531AbSGOQ2e>; Mon, 15 Jul 2002 12:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317534AbSGOQ2d>; Mon, 15 Jul 2002 12:28:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1272 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317531AbSGOQ2b>; Mon, 15 Jul 2002 12:28:31 -0400
Subject: Re: [patch] sched-2.5.24-D3, batch/idle priority scheduling,
	SCHED_BATCH
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, oleg@tv-sign.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20020714122911.GA179@elf.ucw.cz>
References: <Pine.LNX.4.44.0207102143400.16734-100000@localhost.localdomain>
	<Pine.LNX.4.44.0207110913030.4489-100000@localhost.localdomain> 
	<20020714122911.GA179@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Jul 2002 09:31:13 -0700
Message-Id: <1026750676.940.99.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-14 at 05:29, Pavel Machek wrote:

> Does it mean that we now have working scheduler class that only
> schedules jobs when no other thread wants to run (as long as
> SCHED_BATCH task does not enter the kernel)?

Yep.

Now, is the implementation OK?

	Robert Love

