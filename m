Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135246AbRDWOmV>; Mon, 23 Apr 2001 10:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135250AbRDWOmL>; Mon, 23 Apr 2001 10:42:11 -0400
Received: from POBOX.UPENN.EDU ([128.91.2.38]:3600 "EHLO pobox.upenn.edu")
	by vger.kernel.org with ESMTP id <S135246AbRDWOmE>;
	Mon, 23 Apr 2001 10:42:04 -0400
From: Michael J Clark <clarkmic@pobox.upenn.edu>
Message-Id: <200104231442.f3NEg3m05750@pobox.upenn.edu>
Subject: Re: P4 problem with 2.4.3
To: chmouel@mandrakesoft.com (Chmouel Boudjnah)
Date: Mon, 23 Apr 2001 10:42:03 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3pue31xc3.fsf@giants.mandrakesoft.com> from "Chmouel Boudjnah" at Apr 23, 2001 03:53:48 pm
X-Mailer: ELM [version 2.4 PL23-upenn3.3]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe APIC is enabled, it does some kind of check for it.  Everything 
is pretty much default.  I read that the APIC can cause interrupt 
problems,  should I disable it?  If so, is that done in the kernel config?

Mike

> 
> Michael J Clark <clarkmic@pobox.upenn.edu> writes:
> 
> > "wierd, boot kernel (CPU#0) not found in BIOS. "  There is also a message 
> 
> do you have SMP or APIC enabled ?
> 
> -- 
> MandrakeSoft Inc                     http://www.chmouel.org
>                       --Chmouel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

