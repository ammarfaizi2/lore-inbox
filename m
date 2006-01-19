Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422677AbWASWYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWASWYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWASWYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:24:04 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48092 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422678AbWASWYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:24:01 -0500
Subject: Re: RFC: OSS driver removal, a slightly different approach
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
In-Reply-To: <m3ek34vucz.fsf@defiant.localdomain>
References: <20060119174600.GT19398@stusta.de>
	 <m3ek34vucz.fsf@defiant.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 22:21:47 +0000
Message-Id: <1137709308.8471.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 21:24 +0100, Krzysztof Halasa wrote:
> > SOUND_ADLIB
> 
> IIRC 8-bit sound, ISA. GUS on DOS used to emulate it

Very early ISA

> > SOUND_AU1550_AC97
> 
> Never heard but ac97 suggests it's not that old

Embedded platform

> > SOUND_BCM_CS4297A
Ditto

> > SOUND_IT8172
Ditto

> > SOUND_KAHLUA
> 
> Kahlua is a liquor in Mexico named after some ancient (Mayan or Aztec)
> deity :-)
Code name for Cyrix CS5530

> Pro Audio Spectrum. Earlier than GUS? 8-bit I think
PAS16 is the 16bit system, both are prehistoric

> > SOUND_SH_DAC_AUDIO

Embedded

> > SOUND_TRIX
Old sound card

> > SOUND_VIDC
ARM

> > SOUND_VRC5477
Embedded

> > SOUND_VWSND

SGI workstation

> > SOUND_WAVEARTIST

Not sure
