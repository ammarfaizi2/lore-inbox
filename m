Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVKVW4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVKVW4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVKVW4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:56:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:38870 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030218AbVKVW4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:56:32 -0500
Subject: Re: [RFC] Small PCI core patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc Koschewski <marc@osknowledge.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051122140719.GA6784@stiffy.osknowledge.org>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <1132626478.26560.104.camel@gaston>
	 <20051122140719.GA6784@stiffy.osknowledge.org>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 09:53:30 +1100
Message-Id: <1132700011.26560.240.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 15:07 +0100, Marc Koschewski wrote:

> I use my Nvidia card without the Nvidia drivers for long time now. For
> pure X without games and just GNOME and coding I have no need to run the
> proprietary driver at all. But maybe for others (mostly for people with
> laptops where you cannot simply change video cards due to a
> vendor-designed form-factor) it could get worst. What is left for them?
> Run non-X environments on the laptop? Even run Windows on it? Puh!
> 
> A damn stupid circumstance with Nvidia in the end... 

Yes, but at _least_ with nVidia you get this free "nv" driver that they
maintain and that gives you basic mode setting & 2D accel... With the
newest ATI cards, you don't even get that.

Ben.


