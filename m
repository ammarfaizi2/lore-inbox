Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRJaXye>; Wed, 31 Oct 2001 18:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276132AbRJaXy1>; Wed, 31 Oct 2001 18:54:27 -0500
Received: from bitmover.com ([192.132.92.2]:11726 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S276094AbRJaXyK>;
	Wed, 31 Oct 2001 18:54:10 -0500
Date: Wed, 31 Oct 2001 15:54:47 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Cort Dougan <cort@fsmlabs.com>, Craig Milo Rogers <rogers@ISI.EDU>,
        Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Timur Tabi <ttabi@interactivesi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Module Licensing?
Message-ID: <20011031155447.R1506@work.bitmover.com>
Mail-Followup-To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Cort Dougan <cort@fsmlabs.com>, Craig Milo Rogers <rogers@ISI.EDU>,
	Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
	Timur Tabi <ttabi@interactivesi.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20011031092228.J1506@work.bitmover.com> <4986.1004558101@ISI.EDU> <20011031144244.R607@ftsoj.fsmlabs.com> <20011031234707.A9542@kushida.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011031234707.A9542@kushida.jlokier.co.uk>; from lk@tantalophile.demon.co.uk on Wed, Oct 31, 2001 at 11:47:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 11:47:07PM +0000, Jamie Lokier wrote:
> But if you take that strict interpretation, you have _no_ right to copy
> or distribute the object module anyway, except as granted by the license
> on the accompanying source code.

Right you are, but this is trivial to circumvent if you are trying to ship
a binary driver.  The binary doesn't have GPLed code, you are shipping two
things which are not combined when they were shipped, the end user combines
them when running them.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
