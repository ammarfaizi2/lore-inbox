Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131991AbQKWMOd>; Thu, 23 Nov 2000 07:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132069AbQKWMOO>; Thu, 23 Nov 2000 07:14:14 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:8721 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S131991AbQKWMOJ>; Thu, 23 Nov 2000 07:14:09 -0500
Date: Thu, 23 Nov 2000 05:44:03 -0600
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
Message-ID: <20001123054403.S2918@wire.cadcamlab.org>
In-Reply-To: <20001122092356.B53983@sfgoth.com> <200011231115.MAA10903@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011231115.MAA10903@cave.bitwizard.nl>; from R.E.Wolff@bitwizard.nl on Thu, Nov 23, 2000 at 12:15:34PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Rogier Wolff]
> > > +MODULE_PARM(fs_debug, "i");
> > 
> > There's no reason to wrap these "MODULE_PARM"s inside an "#ifdef MODULE".
>                  ^^^^ anymore in 2.4 
                                   ^^^2.2

Verified in 2.2.0 (the oldest tree I have).

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
