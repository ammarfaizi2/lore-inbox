Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132701AbRDYQPf>; Wed, 25 Apr 2001 12:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135891AbRDYQP0>; Wed, 25 Apr 2001 12:15:26 -0400
Received: from [136.159.55.21] ([136.159.55.21]:10465 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S132701AbRDYQPP>; Wed, 25 Apr 2001 12:15:15 -0400
Date: Wed, 25 Apr 2001 10:11:16 -0600
Message-Id: <200104251611.f3PGBG413348@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Pavel Machek <pavel@suse.cz>, John Fremlin <chief@bandits.org>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <20010425162851.D18214@pcep-jamie.cern.ch>
In-Reply-To: <E14pgBe-0003gg-00@the-village.bc.nu>
	<m2k84jkm1j.fsf@boreas.yi.org.>
	<20010420190128.A905@bug.ucw.cz>
	<m2snj3xhod.fsf@bandits.org>
	<20010424021756.A931@pcep-jamie.cern.ch>
	<20010424120649.A23347@bug.ucw.cz>
	<20010425162851.D18214@pcep-jamie.cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier writes:
> Hmm.  Perhaps apmd needs a "do not sync" option, for when you don't care.

Alternatively, use my pmeventd (previously suspendd) from my pmutils
package. You get complete control over all PM events. The daemon sets
no policy (unlike apmd).
http://www.atnf.csiro.au/~rgooch/linux/
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/pmutils.tar.gz

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
