Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129099AbRBCM2J>; Sat, 3 Feb 2001 07:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129254AbRBCM17>; Sat, 3 Feb 2001 07:27:59 -0500
Received: from CPE-61-9-150-57.vic.bigpond.net.au ([61.9.150.57]:3475 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S129099AbRBCM1p>; Sat, 3 Feb 2001 07:27:45 -0500
Date: Sat, 3 Feb 2001 23:38:28 +1100
From: john slee <indigoid@higherplane.net>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Etherworks3 driver now obsolete?
Message-ID: <20010203233828.A32071@higherplane.net>
In-Reply-To: <200102010822.f118Mlu02001@gate.dodgy.net.au> <Pine.LNX.3.96.1010203034048.26992C-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.3.96.1010203034048.26992C-100000@mandrakesoft.mandrakesoft.com>; from jgarzik@mandrakesoft.mandrakesoft.com on Sat, Feb 03, 2001 at 03:42:48AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2001 at 03:42:48AM -0600, Jeff Garzik wrote:
> On Thu, 1 Feb 2001, Darren Tucker wrote:
> > I decided to try a shiny new 2.4.0 kernel but I couldn't configure the driver
> > for my etherworks3 ISA ethernet card (AMD K6III PC hardware).
> >
> > A bit of grepping showed that it only appears if CONFIG_OBSOLETE is defined
> > but nothing in the configuration tools seems to set it (at least for i386).
> 
> If you are willing to be a target^H^H^Htester, then I can probably whip
> up a patch to fix it.

i have two ewrk3 cards here.  if you want stuff tested that can
certainly be arranged, as i'd like to use them.  (i used them with 2.2,
they worked very well)

unfortunately can't test both cards in one machine until i install
linux on a box with more than one isa slot.  maybe a project for
tomorrow :-)

j.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
