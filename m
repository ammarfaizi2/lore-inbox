Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbSKWNbN>; Sat, 23 Nov 2002 08:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267028AbSKWNbN>; Sat, 23 Nov 2002 08:31:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33730 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267026AbSKWNbM>; Sat, 23 Nov 2002 08:31:12 -0500
Date: Sat, 23 Nov 2002 14:38:19 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix compile breakage in drivers/input/gameport
Message-ID: <20021123133818.GG14886@fs.tum.de>
References: <20021118125710.GA11952@fs.tum.de> <20021118143019.B15642@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118143019.B15642@ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 02:30:19PM +0100, Vojtech Pavlik wrote:
> On Mon, Nov 18, 2002 at 01:57:10PM +0100, Adrian Bunk wrote:
> > Hi Matthew,
> > 
> > could you check whether the patch below that does a name -> dev.name to
> > fix the following compile errors is correct?
> 
> Looks Ok to me. Should I merge it in?

Yes.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

