Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318155AbSIITiP>; Mon, 9 Sep 2002 15:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318739AbSIITiP>; Mon, 9 Sep 2002 15:38:15 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:5862 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318155AbSIITiN>; Mon, 9 Sep 2002 15:38:13 -0400
Date: Mon, 9 Sep 2002 22:05:26 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209092122030.4648-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209092204380.1096-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Ingo Molnar wrote:

> this is something i have a 0.5 MB patch for that touches a few hundred
> drivers. I can dust it off if there's demand - it will break almost
> nothing because i've done the hard work of adding the default 'no work was
> done' bit to every driver's IRQ handler.

Could you upload and post a URL?

Thanks,
	Zwane

-- 
function.linuxpower.ca

