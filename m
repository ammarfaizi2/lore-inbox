Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSKKVJw>; Mon, 11 Nov 2002 16:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSKKVJw>; Mon, 11 Nov 2002 16:09:52 -0500
Received: from ns.rf0.com ([198.78.66.18]:29203 "EHLO freebsd.rf0.com")
	by vger.kernel.org with ESMTP id <S261321AbSKKVJv>;
	Mon, 11 Nov 2002 16:09:51 -0500
Date: Mon, 11 Nov 2002 21:16:39 +0000 (GMT)
From: Rus Foster <rghf@fsck.me.uk>
X-X-Sender: rghf@freebsd.rf0.com
To: linux-kernel@vger.kernel.org
Subject: i810_audio
Message-ID: <20021111210447.T90488-100000@freebsd.rf0.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
I've just installed 2.4.20-rc1 to avoid i810 lockups on 2.4.19. However
playing stuff with xmms I've just got

Nov 12 21:03:12 duocity kernel: i810_audio: DMA overrun on write
Nov 12 21:03:12 duocity kernel: i810_audio: CIV 9, LVI 6, hwptr 4808,
count -5640

Also whilst typing this the machine locked hard but nothing in the SYSLOG.
I was moving quickly through my playlist which might of caused an
overrun.  Also is there anyway around the 48Khz only playback as 24Khz
mp3's obviously play to fast
Rgds

Rus

--
http://www.fsck.me.uk - My blog
http://shells.fsck.me.uk - Hosting how you want it.



