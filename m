Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284117AbRLWTsb>; Sun, 23 Dec 2001 14:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284133AbRLWTsV>; Sun, 23 Dec 2001 14:48:21 -0500
Received: from Sophia.Soo.com ([199.202.113.33]:61444 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id <S284117AbRLWTsQ>;
	Sun, 23 Dec 2001 14:48:16 -0500
Date: Sun, 23 Dec 2001 14:48:00 -0500
From: really mason_at_soo_dot_com <lnx-kern@Sophia.soo.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 oddness under X
Message-ID: <20011223144800.A22538@Sophia.soo.com>
In-Reply-To: <20011222164602.A20623@Sophia.soo.com> <3C250835.9010806@wanadoo.fr> <20011223151147.F7438@suse.de> <20011223120825.A22239@Sophia.soo.com> <20011223204227.A13661@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011223204227.A13661@suse.cz>; from vojtech@suse.cz on Sun, Dec 23, 2001 at 08:42:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeps, i do have that param in lilo.conf.  i thot it
was only relevant to PIO modes?  Shows how little i
know abt the IDE drivers.

b

On Sun, Dec 23, 2001 at 08:42:27PM +0100, Vojtech Pavlik wrote:
> On Sun, Dec 23, 2001 at 12:08:25PM -0500, really mason_at_soo_dot_com wrote:
> >  i also have the FSB overclocked so
> > the PCI bus is running at 37mhz.
> 
> And you did tell the VIA ide driver to compensate for the 37MHz, did
> you? ('idebus=37' kernel option)
