Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280798AbRKBS54>; Fri, 2 Nov 2001 13:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280781AbRKBS4Z>; Fri, 2 Nov 2001 13:56:25 -0500
Received: from aloha.egartech.com ([62.118.81.133]:26895 "HELO
	mx02.egartech.com") by vger.kernel.org with SMTP id <S280795AbRKBSzQ>;
	Fri, 2 Nov 2001 13:55:16 -0500
Message-ID: <3BE2DBA9.847AA3C0@egartech.com>
Date: Fri, 02 Nov 2001 20:45:13 +0300
From: Kirill Ratkin <kratkin@egartech.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA->USB
In-Reply-To: <3BE29AC3.DEB4B31A@egartech.com> <3BE2CC18.976C2A9B@osdl.org> <3BE2D20C.3F7E7817@egartech.com> <3BE2D2F9.B9058C81@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2001 17:42:52.0604 (UTC) FILETIME=[CC0A9FC0:01C163C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:
> 
> Kirill Ratkin wrote:
> >
> > "Randy.Dunlap" wrote:
> > >
> > > Kirill Ratkin wrote:
> > > >
> > > > Do somebody make driver for subject device now!?
> > >
> > > Do you have a web page reference for the subject device?
> > No, It isn't finished yet. I thought may be somebody have made it
> > already.
> >
> > >
> > > The usb-ohci driver has been known to work with PCMCIA/USB OHCI
> > > cards.
> 
> Do you mean that you are working on a PCMCIA (CardBus I hope ?)
> to USB card and want to know if it will work with Linux?
> 
> Is it OHCI- or UHCI- or ECHI-based (USB controller)?

I have device (see description below) and I started to find
documentation for it now (I'd like to write driver of it for education
goals). And I ask because may be somebody wrote it already and there
isn't necessary to write same one.

--->>>---
? For PC, Notebook and MAC Powerbook ? Adds two USB ports into your
notebook
computer for instant multiple USB device connections ? Built in driver
support from Apple and
Microsoft PC : Windows 98 , Windows 98 SE, Windows ME, Windows 2000 Mac
: OS 8.6 or
later ? Compliant with USB Specification, Version 1.1 ? Compliant with
OpenHCI
Specification, Revision 1.0a ? Chip set: Opti chip ? Regulatory
approval(s): FCC Class B & CE
? Version: v1.0 
---<<<---

> 
> Or are you just interested in using one?
> 
> ~Randy
