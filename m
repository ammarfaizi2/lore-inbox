Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278068AbRJVHP4>; Mon, 22 Oct 2001 03:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278031AbRJVHPg>; Mon, 22 Oct 2001 03:15:36 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:12548 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S278030AbRJVHPb>;
	Mon, 22 Oct 2001 03:15:31 -0400
Message-Id: <200110220715.f9M7FYL01129@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: linux-kernel@vger.kernel.org
Subject: 2.4.12-ac5: i810_audio does not work
Date: Mon, 22 Oct 2001 10:15:29 +0300
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i810_audio doesn't  work in last kernels (for example 2.4.10-ac12 or 2.4.12-ac5).  It says following at 
startup (after modprobe i810_audio):

i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, IRQ 10
i810_audio: Audio Controller supports 2 channels.
ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2

Andris

