Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314132AbSDQVYs>; Wed, 17 Apr 2002 17:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314133AbSDQVYr>; Wed, 17 Apr 2002 17:24:47 -0400
Received: from ccs.covici.com ([209.249.181.196]:50582 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S314132AbSDQVYq>;
	Wed, 17 Apr 2002 17:24:46 -0400
Date: Wed, 17 Apr 2002 17:24:41 -0400 (EDT)
From: John Covici <covici@ccs.covici.com>
To: Anton Altaparmakov <aia21@cantab.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 nbd.c doesn't compile
In-Reply-To: <5.1.0.14.2.20020417210154.00adde30@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.40.0204171723360.20092-100000@ccs.covici.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I found the patch you posted earlier today -- I had it right
there all the time!

On Wed, 17 Apr 2002, Anton Altaparmakov wrote:

> Compilation is already fixed in the current bitkeeper tree
> (linux.bkbits.net/linux-2.5). so you can either get that or you can apply
> the patch I posted this morning fixing this problem.
>
> You can find the patch in the archives:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101897350106638&w=2
>
> Note patch compiles but is otherwise untested.
>
> Best regards,
>
> Anton
>
> At 20:34 17/04/02, John Covici wrote:
> >When I try to compile 2.5.8 with nbd as a module, I get lots of error
> >saying structure has no member queue_lock .
> >
> >Any assistance would be appreciated.
> >
> >--
> >          John Covici
> >          covici@ccs.covici.com
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
>
>

-- 
         John Covici
         covici@ccs.covici.com

