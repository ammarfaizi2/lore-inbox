Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268444AbTCFWQW>; Thu, 6 Mar 2003 17:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268445AbTCFWQW>; Thu, 6 Mar 2003 17:16:22 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4612 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S268444AbTCFWQU>; Thu, 6 Mar 2003 17:16:20 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303062228.h26MSYYj000170@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH] Fix breakage caused by spelling 'fix'
To: m.c.p@wolk-project.de (Marc-Christian Petersen)
Date: Thu, 6 Mar 2003 22:28:34 +0000 (GMT)
Cc: mike@aiinc.ca, linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <200303062259.20480.m.c.p@wolk-project.de> from "Marc-Christian Petersen" at Mar 06, 2003 10:59:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This fixes a spelling "fix" that resulted in a compile error.
> > With apologies to Russell King.
> > diff -ur a/include/asm-arm/proc-fns.h b/include/asm-arm/proc-fns.h
> > --- a/include/asm-arm/proc-fns.h	Tue Mar  4 19:29:20 2003
> > +++ b/include/asm-arm/proc-fns.h	Thu Mar  6 11:46:15 2003
> > @@ -125,7 +125,7 @@
> >
> >  #if 0
> >   * The following is to fool mkdep into generating the correct
> > - * dependencies.  Without this, it can't figure out that this
> > + * dependencies.  Without this, it cant figure out that this
> A spelling fix should be a right spelling fix ;)
> 
> So either "cannot" or "can not" but not "cant" :)

"Can not" is technically wrong.

http://marc.theaimsgroup.com/?l=linux-kernel&m=104691562715435&w=2

I also fell in to this trap.

John.
