Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTILPE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbTILPE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:04:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21195 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261722AbTILPE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:04:56 -0400
Date: Fri, 12 Sep 2003 17:04:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030912150449.GI27368@fs.tum.de>
References: <20030910195544.GL27368@fs.tum.de> <20030910210443.GG4559@ip68-0-152-218.tc.ph.cox.net> <20030910215136.GP27368@fs.tum.de> <20030910220552.GJ4559@ip68-0-152-218.tc.ph.cox.net> <20030910221710.GT27368@fs.tum.de> <20030910222918.GL4559@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.44.0309111037050.19512-100000@serv> <20030911230448.GA13672@ip68-0-152-218.tc.ph.cox.net> <20030912110902.GF27368@fs.tum.de> <20030912145207.GC13672@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912145207.GC13672@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 07:52:07AM -0700, Tom Rini wrote:
>...
> With 'oldconfig' / 'config', you could loop until the user selects one
> of them.  Or, default to the first in the or series that can be
> selected.

What if all possible dependencies aren't available because their 
dependencies aren't fulfilled?

I agree that there's a problem, but I think a good solution is 
non-trivial.

> Tom Rini

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

