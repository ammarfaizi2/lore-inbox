Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289103AbSAJAmg>; Wed, 9 Jan 2002 19:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289104AbSAJAmQ>; Wed, 9 Jan 2002 19:42:16 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:7558 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S289103AbSAJAmG>;
	Wed, 9 Jan 2002 19:42:06 -0500
Date: Thu, 10 Jan 2002 01:41:16 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Daniel J Blueman <daniel.blueman@btinternet.com>
cc: "'Ville Herva'" <vherva@niksula.hut.fi>,
        "'Andrew Morton'" <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        "'Jani Forssell'" <jani.forssell@viasys.com>
Subject: RE: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
In-Reply-To: <001401c1996c$7d8dd790$0100a8c0@icarus>
Message-ID: <Pine.LNX.4.21.0201100139080.14829-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Daniel J Blueman wrote:

> There are known issues with the VIA 82C686A/B chipset south-bridge and
> IDE in particular. Make sure you have the latest BIOS and latest VIA
> 4in1 drivers to workaround the IDE corruption and other known issues
> (sound problems with certain soundcards).

Yes I'm aware of these problems, I thought that the VIA 4in1 driver where
wintendo drivers. And I also thought that there are workarounds for these
bugs in the kernel. 

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

