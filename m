Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279893AbRKBBKL>; Thu, 1 Nov 2001 20:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279894AbRKBBKC>; Thu, 1 Nov 2001 20:10:02 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:7757 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279893AbRKBBJ4>; Thu, 1 Nov 2001 20:09:56 -0500
Date: Thu, 1 Nov 2001 20:09:55 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: emu10k emits buzzing and crackling
Message-ID: <20011101200955.A1913@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

One of the workstations I use really doesn't like the emu10k driver in 
2.4.13-ac5.  The box is a dual athlon running rh7.2.  Playing mp3s seems 
to work well, but other samples from xfce on shutdown and window close 
result in buzzing and popping noises.  If anyone wants details or patches 
tested, drop me a note.

		-ben

es1371: version v0.30 time 17:42:30 Nov  1 2001
Creative EMU10K1 PCI Audio Driver, version 0.16, 17:42:24 Nov  1 2001
emu10k1: EMU10K1 rev 7 model 0x8040 found, IO at 0x2400-0x241f, IRQ 19
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
usb.c: registered new driver hub
