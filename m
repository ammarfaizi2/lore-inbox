Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290083AbSA3QmS>; Wed, 30 Jan 2002 11:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290045AbSA3Qkx>; Wed, 30 Jan 2002 11:40:53 -0500
Received: from bitmover.com ([192.132.92.2]:56741 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290060AbSA3QkA>;
	Wed, 30 Jan 2002 11:40:00 -0500
Date: Wed, 30 Jan 2002 08:39:59 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jochen Friedrich <jochen@scram.de>
Cc: Larry McVoy <lm@bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
        Jeff Garzik <garzik@havoc.gtf.org>,
        Rob Landley <landley@trommello.org>,
        Miles Lane <miles@megapathdsl.net>, Chris Ricker <kaboom@gatech.edu>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130083959.J23269@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jochen Friedrich <jochen@scram.de>, Larry McVoy <lm@bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Rob Landley <landley@trommello.org>,
	Miles Lane <miles@megapathdsl.net>,
	Chris Ricker <kaboom@gatech.edu>,
	World Domination Now! <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130080642.E18381@work.bitmover.com> <Pine.NEB.4.33.0201301731530.16245-100000@www2.scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.NEB.4.33.0201301731530.16245-100000@www2.scram.de>; from jochen@scram.de on Wed, Jan 30, 2002 at 05:34:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 05:34:12PM +0100, Jochen Friedrich wrote:
> Hi Larry,
> 
> > with the difference being that BK has an optional way of wrapping
> > them up in uuencode (or whatever) so that mailers don't stomp on them.
> 
> isn't that just the same as sending them as attchment? And isn't that
> discouraged?

We have a generic wrapping/unwrapping mechanism.  The wrapping can be as
draconian as a uuencode/mimencoded attachment or as light as a crc envelope.
We don't care, we're mechanism providers in this area, not policy setters.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
