Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280739AbRKBRPi>; Fri, 2 Nov 2001 12:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280740AbRKBRP2>; Fri, 2 Nov 2001 12:15:28 -0500
Received: from air-1.osdl.org ([65.201.151.5]:4360 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S280739AbRKBRPS>;
	Fri, 2 Nov 2001 12:15:18 -0500
Message-ID: <3BE2D2F9.B9058C81@osdl.org>
Date: Fri, 02 Nov 2001 09:08:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kirill Ratkin <kratkin@egartech.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA->USB
In-Reply-To: <3BE29AC3.DEB4B31A@egartech.com> <3BE2CC18.976C2A9B@osdl.org> <3BE2D20C.3F7E7817@egartech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Ratkin wrote:
> 
> "Randy.Dunlap" wrote:
> >
> > Kirill Ratkin wrote:
> > >
> > > Do somebody make driver for subject device now!?
> >
> > Do you have a web page reference for the subject device?
> No, It isn't finished yet. I thought may be somebody have made it
> already.
> 
> >
> > The usb-ohci driver has been known to work with PCMCIA/USB OHCI
> > cards.

Do you mean that you are working on a PCMCIA (CardBus I hope ?)
to USB card and want to know if it will work with Linux?

Is it OHCI- or UHCI- or ECHI-based (USB controller)?

Or are you just interested in using one?

~Randy
