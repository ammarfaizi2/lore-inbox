Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319118AbSHFN1t>; Tue, 6 Aug 2002 09:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319121AbSHFN1t>; Tue, 6 Aug 2002 09:27:49 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:39607 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S319118AbSHFN1s>;
	Tue, 6 Aug 2002 09:27:48 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: venom@sns.it, Thomas Munck Steenholdt <tmus@get2net.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: i810 sound broken...
References: <Pine.LNX.4.43.0208051546120.8463-100000@cibs9.sns.it>
	<1028561325.18478.55.camel@irongate.swansea.linux.org.uk>
	<m31y9dt29p.fsf@lapper.ihatent.com>
	<1028645253.18130.164.camel@irongate.swansea.linux.org.uk>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 06 Aug 2002 15:31:23 +0200
In-Reply-To: <1028645253.18130.164.camel@irongate.swansea.linux.org.uk>
Message-ID: <m3k7n46rmc.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Mon, 2002-08-05 at 22:38, Alexander Hoogerhuis wrote:
> > 
> > Different thing about 810, brand spanking new Compaq
> > Game^H^H^H^Hlaptop and it gives good sound, but shows this on boot:
> > 
> > i810: Intel ICH3 found at IO 0x4400 and 0x4000, IRQ 5
> > i810_audio: Audio Controller supports 6 channels.
> > ac97_codec: AC97 Audio codec, id: 0x4144:0x5363 (Unknown)
> > i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's \
> > not present), total channels = 2
> 
> Thats fine. Your chipset supports 6 channel surround sound. Your vendor
> didn't feel the need to fit codecs for anything more than stereo
> 

Anyone feeling they need the codes IDs to add to some database so they
dont remain "unknown"?

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
