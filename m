Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263929AbRFMAvm>; Tue, 12 Jun 2001 20:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263930AbRFMAvc>; Tue, 12 Jun 2001 20:51:32 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:23254 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S263929AbRFMAvW>;
	Tue, 12 Jun 2001 20:51:22 -0400
Message-ID: <3B26B8FC.106FBA53@candelatech.com>
Date: Tue, 12 Jun 2001 17:51:08 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Brownfield <brownfld@irridia.com>
CC: Florin Andrei <florin@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19: eepro100 and cmd_wait issues
In-Reply-To: <200106121921.OAA05009@asooo.flowerfire.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Brownfield wrote:

> OT: does anyone know what the current state of the Tulip driver is and
> if there is good hardware out there?  SMC left Tulip and went through at
> least two other chipsets, so the only Tulip card I could find as of a
> couple of years ago was Digital's.  But it was astonishingly expensive
> and not clearly supported by the Linux driver.

The current state seems to be 'BUSTED', at least for the cards
that I am trying (ZNYX 4-port, D-LINK 4-port).  (I'm using the 2.4
drivers, btw.)

However, I'm hoping that it will be fixed soon, because the D-LINK
4-port is very cheap compared to other 4-ports out there, and in fact
I haven't found a 4-port card that is NOT tulip based (please let
me know if you have 4-port suggestions!)

Other than one really old EEPRO card I have, the EEPRO cards seem to be
very stable, fast, and feature-complete.

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
