Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWBTROp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWBTROp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWBTROp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:14:45 -0500
Received: from mail.gmx.de ([213.165.64.20]:31413 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161018AbWBTROn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:14:43 -0500
X-Authenticated: #428038
Date: Mon, 20 Feb 2006 18:14:34 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dhazelton@enter.net, matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060220171434.GA31591@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	dhazelton@enter.net, linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <200602161742.26419.dhazelton@enter.net> <43F5B686.nail2VCA2A2OF@burner> <200602171502.20268.dhazelton@enter.net> <43F9D771.nail4AL36GWSG@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9D771.nail4AL36GWSG@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-20:

> > Noted. However even if I do create said patch, I'm more than 90% certain you 
> > won't even take a look at it.
> 
> If your code will have similar relevence than the code from Matthias, you are 
> obviously true.

Well, it is irrelevant to _you_ because it proves you're wrong. At
least, not a single objective argument WRT bugs in side the code have
surfaced.

> One problem is that GNU make is not working in a useful way on many patforms
> that are listed to be working. GNU make is unmaintained since many years and
> a serious bug I reported in 1999 still has not been fixed.

The so-called "serious" bug is a purely cosmetic complaint about
non-existant .d files.

> > Says you. Since the SCSI system via /dev/hd* was just added in, IIRC, the 2.5 
> > series kernel - at the same time ide-scsi was deprecated access via SG_IO 
> > on /dev/hd* is the new method and not deprecated.
> 
> Any system that is worse than another one is deprecated.

Hm. Schilling's applications are worse than others by printing
meaningless warnings...

> If people on LKML believe it is OK not to abide promises and if they don't have 

Your delusions about who "promise"d something to you...

> Well, on such a system, a /dev/hd driver is not needed for the CD-ROM.
> A SCSI disk driver would be sufficient.

Not your business.

-- 
Matthias Andree
