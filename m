Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264134AbRFMBPd>; Tue, 12 Jun 2001 21:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264124AbRFMBPX>; Tue, 12 Jun 2001 21:15:23 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:53439 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S264135AbRFMBPL>; Tue, 12 Jun 2001 21:15:11 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Ben Greear <greearb@candelatech.com>
Cc: Ken Brownfield <brownfld@irridia.com>, Florin Andrei <florin@sgi.com>,
        linux-kernel@vger.kernel.org
Date: Tue, 12 Jun 2001 17:03:27 -0700 (PDT)
Subject: Re: 2.2.19: eepro100 and cmd_wait issues
In-Reply-To: <3B26B8FC.106FBA53@candelatech.com>
Message-ID: <Pine.LNX.4.33.0106121702500.25366-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am useing the D-link 4 port card without running into problems
(admittidly I have not been stressing it much yet)

David Lang

On Tue, 12 Jun 2001, Ben Greear wrote:

> Date: Tue, 12 Jun 2001 17:51:08 -0700
> From: Ben Greear <greearb@candelatech.com>
> To: Ken Brownfield <brownfld@irridia.com>
> Cc: Florin Andrei <florin@sgi.com>, linux-kernel@vger.kernel.org
> Subject: Re: 2.2.19: eepro100 and cmd_wait issues
>
> Ken Brownfield wrote:
>
> > OT: does anyone know what the current state of the Tulip driver is and
> > if there is good hardware out there?  SMC left Tulip and went through at
> > least two other chipsets, so the only Tulip card I could find as of a
> > couple of years ago was Digital's.  But it was astonishingly expensive
> > and not clearly supported by the Linux driver.
>
> The current state seems to be 'BUSTED', at least for the cards
> that I am trying (ZNYX 4-port, D-LINK 4-port).  (I'm using the 2.4
> drivers, btw.)
>
> However, I'm hoping that it will be fixed soon, because the D-LINK
> 4-port is very cheap compared to other 4-ports out there, and in fact
> I haven't found a 4-port card that is NOT tulip based (please let
> me know if you have 4-port suggestions!)
>
> Other than one really old EEPRO card I have, the EEPRO cards seem to be
> very stable, fast, and feature-complete.
>
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
