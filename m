Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbSL2MNY>; Sun, 29 Dec 2002 07:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbSL2MNY>; Sun, 29 Dec 2002 07:13:24 -0500
Received: from smtp5.wanadoo.nl ([194.134.35.176]:39450 "EHLO smtp5.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S266546AbSL2MNX>;
	Sun, 29 Dec 2002 07:13:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: linux-kernel@vger.kernel.org
Subject: Re: es1371 driver: ensoniq 5880 distortion
Date: Sun, 29 Dec 2002 13:21:57 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021229122143.D34DA74EC5@smtp5.wanadoo.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 December 2002 02:13, Tom Vier wrote:
> i have an sb card that uses a 5880. all output from the card is distorted,
> regardless of which output i use, what volume i set the card at, and what i
> play (cat english.au and xmms playing mp3s).

this is my soundcard (from lspci -v):
00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Flags: bus master, slow devsel, latency 64, IRQ 5
        I/O ports at d800 [size=64]
        Capabilities: <available only to root>

I'm using alsa on 2.5.5x and alsa-0.9 on 2.4.2x and all works fine... so what 
kernel(s) are you using and do you have OSS or ALSA drivers??

        Rudmer

