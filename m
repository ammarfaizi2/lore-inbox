Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRKAALy>; Wed, 31 Oct 2001 19:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRKAALf>; Wed, 31 Oct 2001 19:11:35 -0500
Received: from pc-62-31-92-167-az.blueyonder.co.uk ([62.31.92.167]:58863 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S276429AbRKAALZ>; Wed, 31 Oct 2001 19:11:25 -0500
Date: Thu, 1 Nov 2001 00:10:54 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Cort Dougan <cort@fsmlabs.com>, Craig Milo Rogers <rogers@ISI.EDU>,
        Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Timur Tabi <ttabi@interactivesi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Module Licensing?
Message-ID: <20011101001054.B9542@kushida.jlokier.co.uk>
In-Reply-To: <20011031092228.J1506@work.bitmover.com> <4986.1004558101@ISI.EDU> <20011031144244.R607@ftsoj.fsmlabs.com> <20011031234707.A9542@kushida.jlokier.co.uk> <20011031155447.R1506@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031155447.R1506@work.bitmover.com>; from lm@bitmover.com on Wed, Oct 31, 2001 at 03:54:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Wed, Oct 31, 2001 at 11:47:07PM +0000, Jamie Lokier wrote:
> > But if you take that strict interpretation, you have _no_ right to copy
> > or distribute the object module anyway, except as granted by the license
> > on the accompanying source code.
> 
> Right you are, but this is trivial to circumvent if you are trying to ship
> a binary driver.  The binary doesn't have GPLed code, you are shipping two
> things which are not combined when they were shipped, the end user combines
> them when running them.

Indeed, the very old, never resolved, "user does the link" argument again.

I honestly don't know what a court of law would decide on that.  It may
well be different in different jurisdictions.

-- Jamie
