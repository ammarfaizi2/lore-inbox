Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284676AbRLEUy1>; Wed, 5 Dec 2001 15:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284708AbRLEUyR>; Wed, 5 Dec 2001 15:54:17 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:23824 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S284676AbRLEUyI>; Wed, 5 Dec 2001 15:54:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Michael Menegakis <michail@manegakis.freeserve.co.uk>
Reply-To: michail@manegakis.freeserve.co.uk
Organization: none
To: linux-kernel@vger.kernel.org
Subject: Re: USB Camera
Date: Wed, 5 Dec 2001 20:44:45 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Bj3O-0002G5-00.2001-12-05-20-54-07@mail3.svr.pol.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 December 2001 20:25, Joel Jaeggli wrote:
> Got a url for one? any idea what chipset it's using (there are a
> disctinctly finite number of usb camera/capture chipsets...

Thanks joelja. I was just about to ask the usb mailing list but anyway.

The url for the cam's site is here(not very informative):
Let me know if you can assume the chipset it's using.

http://www.digitaldreamco.com

It is DigitalDream, not DigitalDreams. my mistake. The model is l'elegante

http://www.qbik.ch/usb/devices confuces me but it seems to be the key.

KDE USB charactericstics say:

Class  255  (Vendor Specific Class)
Subclass  0
Protocol  0
USB Version  1.16
Vendor ID   0x553   (VLSI Vision Ltd.)
Product ID   0x202
Revision  0.0
Speed   12 Mbit/s
Channels  0
Max. Packet Size  0

(not very informative) SPECS for DigitalDream:

Interface   USB
Sensor  CMOS
Resolution  350 K pixels
Output Resolution  VGA (640 x 480 pixels max)
Lens type   Fixed glass lens
Focus range  1 Metre to infinity
Colours   16.7 million 24 bit
Memory  8MB Ram
No. Of pictures   Low-resolution (up to 106 shots CIF)
                           High-resolution (up to 26 shots VGA)

> joelja
>
> On Wed, 5 Dec 2001, Michael Menegakis wrote:
> > There is a USB WebCam called l'elegant by DigitalDreams. It is quite
> > succesfull here in UK but it doesn't seem to be directly supported by the
> > Linux Kernel. Can you redirect me to right module that may be compatible
> > with it? Or let me know the address of the webcams maintainer, if there
> > is any.
> >
> > Apologies for the off topic message.
> >
> > MichaelM,
> > linuxsale.org
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-------------------------------------------------------
