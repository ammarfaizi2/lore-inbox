Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVKVK7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVKVK7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 05:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVKVK7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 05:59:30 -0500
Received: from mail.enyo.de ([212.9.189.167]:49292 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S964910AbVKVK7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 05:59:30 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Neil Brown <neilb@suse.de>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <20051121225303.GA19212@kroah.com>
	<20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	<21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	<1132623268.20233.14.camel@localhost.localdomain>
	<1132626478.26560.104.camel@gaston>
	<9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
	<17282.39560.978065.606788@cse.unsw.edu.au>
Date: Tue, 22 Nov 2005 11:58:52 +0100
In-Reply-To: <17282.39560.978065.606788@cse.unsw.edu.au> (Neil Brown's message
	of "Tue, 22 Nov 2005 15:11:52 +1100")
Message-ID: <873blpgd8z.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Neil Brown:

> A question worth asking is: Who needs whom?  Do we (FLOSS community)
> need them (Graphics hardware manufactures) or do they need us?

And what do we actually need? 2D graphics, with some very, very basic
acceleration?  Basic 3D support?  Playback of encrypted content?

Personally, I only need very basic 2D sypport, but this is probably
the exception.  The other extreme is the digital media desktop, which
will very soon need to support encrypted video streams.

So what do we want?  What sacrifices in terms of proprietary software
and user restrictions are we willing to make?
