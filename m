Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267695AbRGPUnm>; Mon, 16 Jul 2001 16:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbRGPUnd>; Mon, 16 Jul 2001 16:43:33 -0400
Received: from [154.11.70.101] ([154.11.70.101]:15377 "HELO mtl-vipswitch-01")
	by vger.kernel.org with SMTP id <S267695AbRGPUnS>;
	Mon, 16 Jul 2001 16:43:18 -0400
Date: Mon, 16 Jul 2001 16:26:26 -0400 (EDT)
From: Stephane Dalton <sdalton@vipswitch.com>
X-X-Sender: <sdalton@gemini.vip.ca>
To: <linux-kernel@vger.kernel.org>
Subject: ramfs problems
Message-ID: <Pine.LNX.4.33.0107161622430.28104-100000@gemini.vip.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.4.6 ac2 on a Pentium III 600 Mhz with 384 Mo of memory.

After mounting a ramfs giving the maxsize option a value of 20Mb, I found that
the disk size increase but is not decreasing when files are deleted. Copying
more files give me an not enough space left error message.

Am I the only one with this problem or is it a known bugs, after looking a the
mailing list archive I didn't see any report of this problem.

Thanks

