Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131519AbQKWMWq>; Thu, 23 Nov 2000 07:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131671AbQKWMWh>; Thu, 23 Nov 2000 07:22:37 -0500
Received: from 13dyn248.delft.casema.net ([212.64.76.248]:4356 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S131519AbQKWMWU>; Thu, 23 Nov 2000 07:22:20 -0500
Message-Id: <200011231152.MAA13624@cave.bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
In-Reply-To: <20001123054403.S2918@wire.cadcamlab.org> from Peter Samuelson at
 "Nov 23, 2000 05:44:03 am"
To: Peter Samuelson <peter@cadcamlab.org>
Date: Thu, 23 Nov 2000 12:52:05 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@bitwizard.nl>,
        Mitchell Blank Jr <mitch@sfgoth.com>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
From: R.E.Wolff@bitwizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Rogier Wolff]
> > > > +MODULE_PARM(fs_debug, "i");
> > > 
> > > There's no reason to wrap these "MODULE_PARM"s inside an "#ifdef MODULE".
> >                  ^^^^ anymore in 2.4 
>                                    ^^^2.2
> 
> Verified in 2.2.0 (the oldest tree I have)

Was it really neccesary to make me feel THAT old? :-)

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
