Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVKVDrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVKVDrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbVKVDrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:47:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:62156 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750958AbVKVDrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:47:07 -0500
Subject: Re: [RFC] Small PCI core patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <1132626478.26560.104.camel@gaston>
	 <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 14:44:27 +1100
Message-Id: <1132631067.26560.123.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 22:23 -0500, Jon Smirl wrote:
> On 11/21/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > which is obviously impossible) etc... They really doesn't give a shit
> > about what we think, and will continue to do so until they get a bit fat
> > lawsuit, that is my opinion at least.
> 
> In the US you can't sue to force their hardware open until they are a
> proven monopoly. And as long as we have both Nvidia and ATI splitting
> the market we won't get a monopoly.

No but you can sue for GPL breakage if their blob is considered as a
derivative work or that sort of thing.

> So the choices are:
> 
> 1) Live in 1998. What happens in five years R200's are no longer
> available, fallback to VGA?
>
> 2) Temporarily accept the ugly drivers. Let desktop development
> continue. Work hard on getting the vendors to see the light and go
> open source.

Won't happen without some incentive. Besides, I can't accept the ugly
driver for the very simple reason that they only exist for x86 and I
have no such thing ...

Your other points are totally irrelevant.

Ben.


