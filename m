Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285177AbRLFRJL>; Thu, 6 Dec 2001 12:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLFRJB>; Thu, 6 Dec 2001 12:09:01 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:26131 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S285178AbRLFRI5> convert rfc822-to-8bit;
	Thu, 6 Dec 2001 12:08:57 -0500
Date: Thu, 6 Dec 2001 18:00:58 +0100 (CET)
From: Pascal Junod <pascal.junod@epfl.ch>
X-X-Sender: pjunod@lasecpc10.epfl.ch
To: linux-kernel@vger.kernel.org
cc: dledford@redhat.com
Subject: Re: i810 audio patch
In-Reply-To: <20011206164547.A19660@danielle.hinet.hr>
Message-ID: <Pine.LNX.4.40.0112061752480.3101-100000@lasecpc10.epfl.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'm trying to get sound working on my Sony Vaio PCG-GR114SK laptop with
0.10 patch:

kernel: Intel 810 + AC97 Audio, version 0.10, 17:31:53 Dec  6 2001
kernel: PCI: Setting latency timer of device 00:1f.5 to 64
kernel: i810: Intel ICH3 found at IO 0x18c0 and 0x1c00, IRQ 9
kernel: i810_audio: Audio Controller supports 6 channels.
kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
kernel: i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
kernel: ac97_codec: AC97 Modem codec, id: 0x4358:0x5421 (Unknown)
kernel: i810_audio: timed out waiting for codec 1 analog ready

I have tried alsa drivers 0.9.0beta10 with a little bit more success: I
get some sound, but it's looping forever.

A+

Pascal

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Pascal Junod, pascal.junod@epfl.ch                                 *
* Security and Cryptography Laboratory (LASEC)                       *
* INF 240, EPFL, CH-1015 Lausanne, Switzerland  ++41 (0)21 693 76 17 *
* Montétan 13, CH-1004 Lausanne                 ++41 (0)79 617 28 57 *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




