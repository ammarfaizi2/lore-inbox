Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282668AbRLFTts>; Thu, 6 Dec 2001 14:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282684AbRLFTtj>; Thu, 6 Dec 2001 14:49:39 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:63877 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S282668AbRLFTt3>; Thu, 6 Dec 2001 14:49:29 -0500
Message-ID: <3C0FCBC5.90505@optonline.net>
Date: Thu, 06 Dec 2001 14:49:25 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: pascal.junod@epfl.ch
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That timeout is for the modem codec. The primary, audio codec seems to have initialized properly.

> kernel: Intel 810 + AC97 Audio, version 0.10, 17:31:53 Dec  6 2001
> kernel: PCI: Setting latency timer of device 00:1f.5 to 64
> kernel: i810: Intel ICH3 found at IO 0x18c0 and 0x1c00, IRQ 9
> kernel: i810_audio: Audio Controller supports 6 channels.
> kernel: ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
> kernel: i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
> kernel: ac97_codec: AC97 Modem codec, id: 0x4358:0x5421 (Unknown)
> kernel: i810_audio: timed out waiting for codec 1 analog ready



