Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129942AbRBFSXH>; Tue, 6 Feb 2001 13:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129945AbRBFSW6>; Tue, 6 Feb 2001 13:22:58 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:8965 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129833AbRBFSWs>;
	Tue, 6 Feb 2001 13:22:48 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Date: Tue, 6 Feb 2001 19:21:24 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Matrox G450 problems with 2.4.0 and xfree
CC: J Brook <jbk@postmark.net>, <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <14BA879D6F34@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Feb 01 at 13:16, Mike A. Harris wrote:
> On Wed, 31 Jan 2001, Petr Vandrovec wrote:
> 
> >>  I don't have Windows installed on my machine, but I find that if I
> >> cold boot to 2.2 (RH7) first and start up X (4.0.2 with Matrox driver
                                                             ^^^^^^^^^^^^^
> >> 1.00.04 compiled in), I am then able to "shutdown -r now" and warm
     ^^^^^^^^^^^^^^^^^^^
> >
> >Yes, they use same secret code... At least I think...
> 
> Are you refering to Windows or Red Hat Linux?  I can assure you
> that Red Hat Linux's XFree package doesn't have any secret code
> in it with 110% certainty.  Nor will it have in the future.

He is using XF4.0.2 with Matrox large-blob driver, not with XFree one.
I'm 111% sure that this module contains code which is not freely 
available to mortals.

XFree4.0.2 mga driver does not work with G450 at all. I'm not sure whether
you (or RedHat) applied G450 patches flying around. But it is still first
head only, no digital LCD...
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
