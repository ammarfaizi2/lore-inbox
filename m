Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130889AbQKIOiq>; Thu, 9 Nov 2000 09:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbQKIOig>; Thu, 9 Nov 2000 09:38:36 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:34310 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130889AbQKIOiR>;
	Thu, 9 Nov 2000 09:38:17 -0500
Message-ID: <3A0AB6AD.5FE46D21@mandrakesoft.com>
Date: Thu, 09 Nov 2000 09:37:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <E13tsex-0001Cs-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Actually, he's been quite specific.  It's ok to have binary modules as
> > long as they conform to the interface defined in /proc/ksyms.
> 
> What is completely unclear is if he has the authority to say that given that
> there is code from other people including the FSF merged into the tree.

I've always wondered if we shouldn't encourage people to assign the
copyright for their code to Linux International[1], or some other truly
neutral organization like the FSF[2].  gcc and related projects assign
their copyrights to the FSF to avoid messes like this...

At this point we couldn't force people to change their copyright, but we
can encourage, if LI or another entity exists to which copyrights can be
assigned.

	Jeff


[1] After talking to LI lawyers and getting it all set up, etc.
[2] In this particular case, due to the modified kernel GPL, FSF is
probably a bad target for copyright assignments.

-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
