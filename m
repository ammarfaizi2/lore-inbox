Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290678AbSAYNzh>; Fri, 25 Jan 2002 08:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290679AbSAYNz1>; Fri, 25 Jan 2002 08:55:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:12960 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290678AbSAYNzZ>;
	Fri, 25 Jan 2002 08:55:25 -0500
Date: Fri, 25 Jan 2002 16:52:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: The Doctor What <docwhat@gerf.org>
Cc: <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
Subject: Re: O(1) on powerpc....
In-Reply-To: <20020125000016.A4561@gerf.org>
Message-ID: <Pine.LNX.4.33.0201251651430.9011-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Jan 2002, The Doctor What wrote:

> I tried to compile the O(1) patch on the powerpc kernel (using BenH's
> latest greatest).  But it didn't work.  It puked on the counter and
> processor stuff in mk_def.c:4[01] in arch/powerpc/kernel
>
> Is this patch just incompatable with the powerpc in some way, or is it
> something that hasn't been addressed because Ingo has only ia32
> systems at his disposal?

i think Anton has patches to make PowerPC work - Anton?

	Ingo

