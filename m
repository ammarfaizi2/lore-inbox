Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316346AbSEOGOx>; Wed, 15 May 2002 02:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316347AbSEOGOx>; Wed, 15 May 2002 02:14:53 -0400
Received: from ra.elvis.ru ([194.190.192.34]:21199 "EHLO ra.elvis.ru")
	by vger.kernel.org with ESMTP id <S316346AbSEOGOw>;
	Wed, 15 May 2002 02:14:52 -0400
Date: Wed, 15 May 2002 10:14:51 +0400
From: Oleg Amiton <alick@elvis.ru>
To: linux-kernel@vger.kernel.org
Subject: i810_audio support
Message-ID: <20020515061450.GB1250@elvis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Elvis+
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've just tried to use this sound card (embedded on motherboard) and
got the much of crackling and noise with proper sound.
Is this problem known and fixed already?

modprobe'ing of i810_audio.o and ac97_codec results here:

-- cut --
i810: Intel ICH2 found at IO 0xe000 and 0xdc00, IRQ 9
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x8384:0x7600 (SigmaTel STAC????)
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
-- end --

why last two lines appeared?
