Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278031AbRJVHfl>; Mon, 22 Oct 2001 03:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278038AbRJVHfb>; Mon, 22 Oct 2001 03:35:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28423 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278031AbRJVHfU>; Mon, 22 Oct 2001 03:35:20 -0400
Subject: Re: 2.4.12-ac5: i810_audio does not work
To: pavenis@latnet.lv (Andris Pavenis)
Date: Mon, 22 Oct 2001 08:41:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110220715.f9M7FYL01129@hal.astr.lu.lv> from "Andris Pavenis" at Oct 22, 2001 10:15:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vZiZ-00010n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, IRQ 10
> i810_audio: Audio Controller supports 2 channels.
> ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
> i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2

The messages seem ok. It found a 2 channel device with no surround support.
What part of the system then fails ?
