Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVKVXGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVKVXGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbVKVXGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:06:37 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:46217 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1030233AbVKVXGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:06:36 -0500
Date: Wed, 23 Nov 2005 00:06:48 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Marc Koschewski <marc@osknowledge.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122230648.GA7482@stiffy.osknowledge.org>
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <20051122140719.GA6784@stiffy.osknowledge.org> <1132700011.26560.240.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132700011.26560.240.camel@gaston>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2005-11-23 09:53:30 +1100]:

> On Tue, 2005-11-22 at 15:07 +0100, Marc Koschewski wrote:
> 
> > I use my Nvidia card without the Nvidia drivers for long time now. For
> > pure X without games and just GNOME and coding I have no need to run the
> > proprietary driver at all. But maybe for others (mostly for people with
> > laptops where you cannot simply change video cards due to a
> > vendor-designed form-factor) it could get worst. What is left for them?
> > Run non-X environments on the laptop? Even run Windows on it? Puh!
> > 
> > A damn stupid circumstance with Nvidia in the end... 
> 
> Yes, but at _least_ with nVidia you get this free "nv" driver that they
> maintain and that gives you basic mode setting & 2D accel... With the
> newest ATI cards, you don't even get that.
> 
> Ben.

I use xorg's 'nv' driver. That one is _not_ from nVidia, it it?
