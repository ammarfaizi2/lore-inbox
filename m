Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288010AbSAMTD1>; Sun, 13 Jan 2002 14:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287976AbSAMTDR>; Sun, 13 Jan 2002 14:03:17 -0500
Received: from ptldme-smtp2.maine.rr.com ([204.210.65.67]:35251 "EHLO
	ptldme-mls2.maine.rr.com") by vger.kernel.org with ESMTP
	id <S288010AbSAMTDI>; Sun, 13 Jan 2002 14:03:08 -0500
Message-ID: <3C41DA53.D91FE6E2@maine.rr.com>
Date: Sun, 13 Jan 2002 14:04:51 -0500
From: "David B. Stevens" <dsteven3@maine.rr.com>
Organization: Penguin Preservation Society
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>, Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -H7
In-Reply-To: <20020113185732.72ea3aa8.skraw@ithnet.com>
		<Pine.LNX.4.33.0201132056360.8784-100000@localhost.localdomain> <20020113194958.62f8f674.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works fine on top of 2.4.18-pre3 in UP config.

This e-maile is from such a system.

Cheers,
  Dave



Stephan von Krawczynski wrote:
> 
> On Sun, 13 Jan 2002 20:58:12 +0100 (CET)
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> >
> > On Sun, 13 Jan 2002, Stephan von Krawczynski wrote:
> >
> > > sched.o sched.c sched.c:21: asm/sched.h: No such file or directory
> >
> > Please re-download the 2.4.17 -H7 patch, i've fixed this.
> 
> Ok, I tried on top of vanilla 2.4.17 and it works.
> 
> Seems like 2.4.18-pre3 and H7 don't like each other :-)
> 
> Regards,
> Stephan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
