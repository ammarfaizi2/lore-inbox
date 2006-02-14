Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWBNQxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWBNQxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWBNQxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:53:23 -0500
Received: from mail.gmx.de ([213.165.64.21]:43650 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422649AbWBNQxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:53:22 -0500
X-Authenticated: #428038
Date: Tue, 14 Feb 2006 17:53:18 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060214165318.GB7860@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060213.160108.13290.atrey@ucw.cz> <43F0B32D.nailKUS1E3S8I3@burner> <200602131842.02377.dhazelton@enter.net> <Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr> <43F1F196.nailMWZE1HZK5@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F1F196.nailMWZE1HZK5@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-14:

> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> > >
> > >> -	SCSI commands are bastardized on ATAPI
> > >
> > >identify the problem - provide a test case or two and I'll get off my lazy ass 
> > >and see if I can't figure out what's causing the problem.
> > >
> >
> > Maybe we can put a testsuite together that sends all sorts of commands to a 
> > cd drive and then see with 1. which Linuxes 2. which models it happens.
> 
> You need to ask around for people with problems....
> Debian had some relevent data but removed it the day I was referring to it :-(

In other words: you cannot provide details or even prove the asserted
bug, and you are trying to shift the blame on Debian. If they no longer
have the reports, chances are the bugs have been fixed since through
Debian patches, that's their workflow.

And if you want Debian bugs, look here:
http://bugs.debian.org/cgi-bin/pkgreport.cgi?which=pkg&data=cdrecord&archive=no&version=&dist=unstable&pend-exc=fixed&pend-exc=done&sev-exc=wishlist&sev-exc=fixed

But keep in mind only the "forwarded" or "upstream" bugs are your
business.

Besides that, I wouldn't exactly call it quality standard if you lose
important bug reports about the environment.

-- 
Matthias Andree
