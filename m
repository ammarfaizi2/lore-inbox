Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131295AbQKHC0x>; Tue, 7 Nov 2000 21:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbQKHC0n>; Tue, 7 Nov 2000 21:26:43 -0500
Received: from mail.dotcast.com ([63.80.240.20]:1040 "EHLO
	DC-SRVR1.dotcast.com") by vger.kernel.org with ESMTP
	id <S131229AbQKHC0a>; Tue, 7 Nov 2000 21:26:30 -0500
Message-ID: <52C41B218DE28244B071A1B96DD474F6280154@DC-SRVR1.dotcast.com>
From: Marty Fouts <marty@dotcast.com>
To: "'davej@suse.de'" <davej@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jmerkey@timpanogas.org
Subject: RE: Installing kernel 2.4
Date: Tue, 7 Nov 2000 18:25:03 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's been a bunch of related work done at the Oregon Graduate Institute
by Calton Pu and others.  See
http://www.cse.ogi.edu/DISC/projects/synthetix/publications.html for a list
of papers.



> -----Original Message-----
> From: davej@suse.de [mailto:davej@suse.de]
> Sent: Tuesday, November 07, 2000 3:25 PM
> To: Linux Kernel Mailing List
> Cc: jmerkey@timpanogas.org
> Subject: Re: Installing kernel 2.4
> 
> 
> 
> > There are tests for all this in the feature flags for intel and
> > non-intel CPUs like AMD -- including MTRR settings.  All of 
> this could
> > be dynamic.  Here's some code that does this, and it's similiar to
> > NetWare.  It detexts CPU type, feature flags, special instructions,
> > etc.  All of this on x86 could be dynamically detected.
> 
> Detecting the CPU isn't the issue (we already do all this), 
> it's what to
> do when you've figured out what the CPU is. Show me code that can
> dynamically adjust the alignment of the routines/variables/structs
> dependant upon cacheline size.
> 
> regards,
> 
> Davej.
> 
> -- 
> | Dave Jones <davej@suse.de>  http://www.suse.de/~davej
> | SuSE Labs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
