Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272044AbRIDRzZ>; Tue, 4 Sep 2001 13:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272034AbRIDRzQ>; Tue, 4 Sep 2001 13:55:16 -0400
Received: from jive.SoftHome.net ([204.144.231.93]:12007 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S272044AbRIDRzC>;
	Tue, 4 Sep 2001 13:55:02 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 4 Sep 2001 13:54:43 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re[05]: Question Re AC Patch with VM Tuneable Parms for now
Reply-to: jlmales@softhome.net
CC: linux-kernel@vger.kernel.org
Message-ID: <3B94DD23.23714.3DD82D@localhost>
In-Reply-To: <3B943CB0.14656.754C73@localhost> from "John L. Males" at Sep 04, 2001 02:30:08 AM
In-Reply-To: <E15eI05-0003k5-00@the-village.bc.nu>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan,

Thanks for confirming the VM tuneable parameters are set via the
/proc.


Regards,

John L. Males
Willowdale, Ontario
Canada
04 September 2001 13:54
mailto:jlmales@softhome.net


Subject:        	Re: Question Re AC Patch with VM Tuneable Parms for
now
To:             	jlmales@softhome.net
Date sent:      	Tue, 4 Sep 2001 16:20:29 +0100 (BST)
Copies to:      	linux-kernel@vger.kernel.org
From:           	Alan Cox <alan@lxorguk.ukuu.org.uk>

> > Can someone advise me if the "Make several vm behaviours tunable
> > for now" as of the 2.4.9-ac4 patch are implemented in the kernel
> > .config file?  If so is there an easy way to carry forward a
> > 2.4.8 version of
> 
> They are in /proc
> 
> > the .config file using "make xconfig" so that I do not have to
> > set all the setting I have made from scratch?  I get the sense
> > from the 
> 
> Make oldconfig


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use 
<http://www.pgp.com>

iQA/AwUBO5UjbeAqzTDdanI2EQI6NgCg/knbU1jUslN9fghSkX+ATtSjRK8An1qp
KWVcObgu/BKDkuVkDpTp3rrC
=+GQB
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
